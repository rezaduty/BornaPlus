<?php

namespace Amelia\Backblaze;

use BadMethodCallException;
use ChrisWhite\B2\Client;
use League\Flysystem\Adapter\AbstractAdapter;
use League\Flysystem\Adapter\Polyfill\NotSupportingVisibilityTrait;
use League\Flysystem\Config;
use GuzzleHttp\Psr7;

class Adapter extends AbstractAdapter
{
	
	use NotSupportingVisibilityTrait;

    protected $client;

    protected $bucketName;
    protected $prefix;
	
    /**
     * The custom domain in use for backblaze, if set.
     *
     * @var string
     */
    protected $host;

    /**
     * BackblazeAdapter constructor.
     *
     * @param \ChrisWhite\B2\Client $client
     * @param string $bucketName
     * @param string $host
     */
    public function __construct(Client $client, $bucketName, $host = null, $prefix = null)
    {
        $this->host = $host;
		$this->client = $client;
        $this->bucketName = $bucketName;
        $this->prefix = $prefix;
		
    }
	
	 /**
     * {@inheritdoc}
     */
    public function has($path)
    {
        return $this->getClient()->fileExists(['FileName' => $this->prefix.$path, 'BucketName' => $this->bucketName]);
    }

    /**
     * {@inheritdoc}
     */
    public function write($path, $contents, Config $config)
    {
        $file = $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => $contents
        ]);
        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function writeStream($path, $resource, Config $config)
    {
        $file = $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => $resource
        ]);
        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function update($path, $contents, Config $config)
    {
        $file = $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => $contents
        ]);
        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function updateStream($path, $resource, Config $config)
    {
        $file = $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => $resource
        ]);
        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function read($path)
    {
        $file = $this->getClient()->getFile([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
        ]);
        $fileContent = $this->getClient()->download([
            'FileId' => $file->getId()
        ]);
        return ['contents' => $fileContent];
    }

    /**
     * {@inheritdoc}
     */
    public function readStream($path)
    {
        $stream = Psr7\stream_for();
        $download = $this->getClient()->download([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'SaveAs' => $stream,
        ]);
        $stream->seek(0);
        try {
            $resource = Psr7\StreamWrapper::getResource($stream);
        } catch (InvalidArgumentException $e) {
            return false;
        }
        return $download === true ? ['stream' => $resource] : false;
    }

    /**
     * {@inheritdoc}
     */
    public function rename($path, $newpath)
    {
        return false;
    }

    /**
     * {@inheritdoc}
     */
    public function copy($path, $newPath)
    {
        return $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => @file_get_contents($path)
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function delete($path)
    {
        return $this->getClient()->deleteFile(['FileName' => $this->prefix.$path, 'BucketName' => $this->bucketName]);
    }

    /**
     * {@inheritdoc}
     */
    public function deleteDir($path)
    {
        return $this->getClient()->deleteFile(['FileName' => $this->prefix.$path, 'BucketName' => $this->bucketName]);
    }

    /**
     * {@inheritdoc}
     */
    public function createDir($path, Config $config)
    {
        return $this->getClient()->upload([
            'BucketName' => $this->bucketName,
            'FileName' => $this->prefix.$path,
            'Body' => ''
        ]);
    }

    /**
     * {@inheritdoc}
     */
    public function getMetadata($path)
    {
        return false;
    }

    /**
     * {@inheritdoc}
     */
    public function getMimetype($path)
    {
        return false;
    }

    /**
     * {@inheritdoc}
     */
    public function getSize($path)
    {
        $file = $this->getClient()->getFile(['FileName' => $this->prefix.$path, 'BucketName' => $this->bucketName]);

        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function getTimestamp($path)
    {
        $file = $this->getClient()->getFile(['FileName' => $this->prefix.$path, 'BucketName' => $this->bucketName]);

        return $this->getFileInfo($file);
    }

    /**
     * {@inheritdoc}
     */
    public function getClient()
    {
        return $this->client;
    }

    /**
     * {@inheritdoc}
     */
    public function listContents($directory = '', $recursive = false)
    {
        $fileObjects = $this->getClient()->listFiles([
            'BucketName' => $this->bucketName,
        ]);
        if ($recursive === true && $directory === '') {
            $regex = '/^.*$/';
        } else if ($recursive === true && $directory !== '') {
            $regex = '/^' . preg_quote($directory) . '\/.*$/';
        } else if ($recursive === false && $directory === '') {
            $regex = '/^(?!.*\\/).*$/';
        } else if ($recursive === false && $directory !== '') {
            $regex = '/^' . preg_quote($directory) . '\/(?!.*\\/).*$/';
        } else {
            throw new \InvalidArgumentException();
        }
        $fileObjects = array_filter($fileObjects, function ($fileObject) use ($directory, $regex) {
            return 1 === preg_match($regex, $fileObject->getName());
        });
        $normalized = array_map(function ($fileObject) {
            return $this->getFileInfo($fileObject);
        }, $fileObjects);
        return array_values($normalized);
    }

    /**
     * Get file info
     *
     * @param $file
     *
     * @return array
     */

    protected function getFileInfo($file)
    {
        $normalized = [
            'type' => 'file',
            'path' => $this->prefix.$file->getName(),
            'timestamp' => substr($file->getUploadTimestamp(), 0, -3),
            'size' => $file->getSize()
        ];

        return $normalized;
    }

    /**
     * Get the URL to the given path.
     *
     * @param $path
     * @return string
     */
    public function getUrl($path)
    {
        if (! $this->host) {
            throw new BadMethodCallException("The 'host' key must be set in the b2 storage adapter to fetch URLs.");
        }

        return 'https://' . $this->host . '/file/' . $this->bucketName . '/' . $this->prefix.$path;
    }
}
