<?php


namespace App\Http\Controllers\Account;

use App\Http\Controllers\Controller;

use App\Models\User;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;


class NewsController extends Controller
{
   
    private $client;
    

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->client=new Client(['base_uri' => 'http://195.248.243.32:8000']);
        $this->middleware('auth');
    }

    
    public function store(Request $request)
    {
      return $request;

    }



    public function indexCategory(Request $request)
    {

      
        
      $response = $this->client->get('rest/category');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('account.category.index')->with('categories',$entries);
		
    }



    public function indexNews(Request $request)
    {
      //return $_SERVER["REMOTE_ADDR"];
     
      $response = $this->client->get('rest/news');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());
      return view('account.news.index')->with('news',$entries);
    
    }

    public function createNews(Request $request)
    {
      $response = $this->client->get('rest/category');
      $cat = json_decode($response->getBody(),true);
      
      return view('account.news.create')->with('categories',$cat);
    }

    /**
    * Store a newly created resource in storage.
    * 172.16.238.1:8000/api/v1/media
    * 172.16.238.1:8000/api/v1/posts
    * 172.16.238.1:8000/api/v1/authenticate
    */
    public function storeNews(Request $request)
    {
      $title = $request['title'];
      $content = $request['post-ckeditor'];
      $cat_id = $request['cat_id'];
      $top = $request['top'];
      $posted_at = date("Y-m-d H:i:s");

      $thumbnail_id = 1;
      
      if($request->hasFile('image')){
        $response = $this->client->request('POST','api/v1/media', [
          'headers' => [
          
            'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
          ],
        'multipart' => [
          [
          'Content-type' => 'multipart/form-data',
          'name' => 'image',
          
          'contents' => fopen($request->file('image'),'r')
          ]
        ]
        
        ]);
        $body = json_decode($response->getBody()->getContents(),true);
        $thumbnail_id = $body['data']['id'];
      }

      $response = $this->client->request('POST','api/v1/authenticate', [
       'form_params' => [
        'email' => 'darthvader@deathstar.ds',
        'password' => '4nak1n'
       ]
       
      ]);
      $body = json_decode($response->getBody()->getContents(),true);
      $author_id = $body['data']['id'];

      $response = $this->client->request('POST','api/v1/posts', [
       
        'form_params' => [
         'title' => $title,
         'content' => $content,
         'cat_id' => $cat_id,
         'posted_at' => $posted_at,
         'thumbnail_id' => $thumbnail_id,
         'top' => $top,
         'author_id' => $author_id
        ],
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
       $body =  json_decode($response->getBody()->getContents(),true);

       if($body['data']['id']){
        return redirect()->route( 'account.getNews' );
       }else{
        return redirect()->route( 'account.getNews' );
       }




    }

    public function destroyNews(Request $request,$title)
    { 
      
      $response = $this->client->delete('api/v1/posts/'.$title, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $news = json_decode($response->getBody(),true);
      return redirect()->route( 'account.getNews' );


    }

    public function editNews(Request $request,$title)
    {
      $response = $this->client->get('rest/category');
      $cat = json_decode($response->getBody(),true);

      
      $response = $this->client->get('api/v1/posts/'.$title, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $post = json_decode($response->getBody(),true);
      $post = $post['data'];
      return view('account.news.edit')->with("post",$post)->with("categories",$cat);
        
    }

    public function updateNews(Request $request,$title)
    {
      $old_title = $request['old_title'];

      $title = $request['title'];
      $content = $request['post-ckeditor'];
      $cat_id = $request['cat_id'];
      $top = $request['top'];
      $request['posted_at']=date("Y-m-d H:i:s");
      
      $thumbnail_id = '';
      
      if($request->hasFile('image')){
        $response = $this->client->request('POST','api/v1/media', [
          'headers' => [
          
            'Authorization' => 'Bearer  hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
          ],
        'multipart' => [
          [
          'Content-type' => 'multipart/form-data',
          'name' => 'image',
          
          'contents' => fopen($request->file('image'),'r')
          ]
        ]
        
        ]);
        $body = json_decode($response->getBody()->getContents(),true);
        
        $thumbnail_id = $body['data']['id'];
    }

      $response = $this->client->request('POST','api/v1/authenticate', [
       'form_params' => [
        'email' => 'darthvader@deathstar.ds',
        'password' => '4nak1n'
       ]
       
      ]);
      $body = json_decode($response->getBody()->getContents(),true);
      $author_id = $body['data']['id'];

      $response = $this->client->request('POST','api/v1/posts/update/'.$old_title, [
       
        'form_params' => [
          'old_title' => $old_title,
          'title' => $title,
          'content' => $content,
          'top' => $top,
          'cat_id' => $cat_id,
          'thumbnail_id' => $thumbnail_id,
          'author_id' => $author_id,
          'posted_at' => $request['posted_at'],
        ],
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
       
       $body =  json_decode($response->getBody()->getContents(),true);
       
       if($body[0]['data']!=200){
        return redirect()->route( 'account.getNews' );
       }else{
        return redirect()->route( 'account.getNews' );
       }

    }






    public function createCategory(Request $request)
    {
      
      return view('account.category.create');
    }

    public function storeCategory(Request $request)
    {

      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createcategory', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'account.getCategory' );
      }
    }



    public function editCategory(Request $request,$id)
    {
      $response = $this->client->get('rest/editcategory/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('account.category.edit')->with("id",$id)->with("cat",$cat);

        
    }

    public function updateCategory(Request $request,$id)
    {
      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);
$cat = Category::OrderBy('id','desc')->where('id', $id)->update(['content' => $request['content']]);
        if($cat){
            return "200";
        }
      
      $response = $this->client->post('rest/updatecategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'account.getCategory' );
      }
    }
    public function destroyCategory(Request $request,$id)
    {
      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/destroycategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'account.getCategory' );
      }
    }

    

}













    

}
