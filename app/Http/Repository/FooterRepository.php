<?php
namespace App\Http\Repository;
use Illuminate\Support\Collection;
use GuzzleHttp\Client;
/**
* Movie Repository class
*/
class FooterRepository
{

    public function __construct()
    {
        //$this->middleware('auth');
        $this->client=new Client(['base_uri' => 'http://172.16.238.1:8000']);
    }


    public function getContact()
    {
    	$response = $this->client->get('rest/access');
        $contact = json_decode($response->getBody(),true);
        return $contact;
    }

    public function getSocial()
    {
    	$response = $this->client->get('rest/social');
        $social = json_decode($response->getBody(),true);
        return $social;
    }
    public function getLatestNews()
    {
    	$response = $this->client->get('rest/latestnewsinfooter');
        $lnews = json_decode($response->getBody(),true);
        return $lnews;
    }
}