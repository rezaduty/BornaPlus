<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use GuzzleHttp\Client;
use App\Models\Listing;
use App\Models\Category;
use Orchestra\Support\Facades\Table;
use Orchestra\Support\Facades\HTML;
use App\DataTables\ListingsDataTable;

class DashboardController extends Controller
{

    private $client;
    
    public function convertEntoFaNum($string) {
        $persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
        $arabic = ['٩', '٨', '٧', '٦', '٥', '٤', '٣', '٢', '١','٠'];

        $num = range(0, 9);
        $convertedPersianNums = str_replace($persian, $num, $string);
        $englishNumbersOnly = str_replace($arabic, $num, $convertedPersianNums);

        return $englishNumbersOnly;
    }

     public function __construct()
    {
        $this->client=new Client(['base_uri' => 'http://172.16.238.1:8000']);
    }


    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(Request $request)
    {
        if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }



      $response = $this->client->get('rest/dashboard/count');
      $count = json_decode($response->getBody(),true);
      return view('panel::dashboard.index')->with("index",'active')->with('admin_news_count',$count['admin_news_count'])->with('user_news_count',$count['user_news_count'])->with('morghzendeprice',$count['morghzendeprice'])->with('rasprice',$count['rasprice'])->with('plusprice',$count['plusprice'])->with('rnews',$count['rnews'])->with('news',$count['news'])->with('pnews',$count['pnews']);
    }







     public function indexContact(Request $request)
    {

      
        
      $response = $this->client->get('rest/contact');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('panel::dashboard.contact.index')->with('contact',$entries)->with("contact_active",'active');
    
    }


    public function createContact(Request $request)
    {
      
      return view('panel::dashboard.contact.create')->with("contact_active",'active');
    }

    public function storeContact(Request $request)
    {

      $payload = array('title' => $request['title'],'description' => $request['description'],'name' => $request['name'],'email' => $request['email'],'phone' => $request['phone'],'reply_status'=>'','reply_msg'=>'');

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createcontact', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getContact' );
      }
    }



    public function editContact(Request $request,$id)
    {
      $response = $this->client->get('rest/editcontact/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.contact.edit')->with("id",$id)->with("cat",$cat)->with("contact_active",'active');

        
    }

    public function updateContact(Request $request,$id)
    {
      $payload = array('title' => $request['title'],'description' => $request['description'],'name' => $request['name'],'email' => $request['email'],'phone' => $request['phone'],'reply_status'=>'','reply_msg'=>'');

      $payload = json_encode($payload);
      
      $response = $this->client->post('rest/updatecontact/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getContact');
      }
    }
    public function destroyContact(Request $request,$id)
    {

      
      $response = $this->client->post('rest/destroycontact/'.$id, [
       'debug' => FALSE,
       'body' => '',
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getContact' );
      }
    }




    public function indexAbout(Request $request)
    {
        if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }


  //return $_SERVER["REMOTE_ADDR"];
     
      $response = $this->client->get('rest/about');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());
      return view('panel::dashboard.about.index')->with('about',$entries)->with("about_active",'active');
    }


    public function createAbout(Request $request)
    {
      
      return view('panel::dashboard.about.create');
    }

    /**
    * Store a newly created resource in storage.
    * 172.16.238.1:8000/api/v1/media
    * 172.16.238.1:8000/api/v1/posts
    * 172.16.238.1:8000/api/v1/authenticate
    */
    public function storeAbout(Request $request)
    {
      $title = $request['title'];
      $description = $request['post-ckeditor'];
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

      $response = $this->client->request('POST','api/v1/about', [
       
        'form_params' => [
         'title' => $title,
         'description' => $description,
         'posted_at' => $posted_at,
         'thumbnail_id' => $thumbnail_id
        ],
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
       $body =  json_decode($response->getBody()->getContents(),true);

       if($body['data']['id']){
        return redirect()->route( 'panel.getAbout' );
       }else{
        return redirect()->route( 'panel.getAbout' );
       }




    }


 public function editAbout(Request $request,$id)
    {
      
      $response = $this->client->get('rest/about/'.$id, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $post = json_decode($response->getBody(),true);
      $post = $post['data'];
      return view('panel::dashboard.about.edit')->with("about",$post);
        
    }

    public function updateAbout(Request $request,$id)
    {
      $old_title = $request['old_title'];

      $title = $request['title'];
      $description = $request['post-ckeditor'];
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

      $response = $this->client->request('POST','api/v1/about/update/'.$id, [
       
        'form_params' => [
          'old_title' => $old_title,
          'title' => $title,
          'description' => $description,
          'thumbnail_id' => $thumbnail_id
        ],
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
       
       $body =  json_decode($response->getBody()->getContents(),true);
       
       if($body[0]['data']!=200){
        return redirect()->route( 'panel.getAbout' );
       }else{
        return redirect()->route( 'panel.getAbout' );
       }

    }


    public function destroyAbout(Request $request,$id)
    { 
      
      $response = $this->client->delete('api/v1/about/'.$id, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $news = json_decode($response->getBody(),true);
      return redirect()->route( 'panel.getAbout' );


    }










    public function indexAccess(Request $request)
    {

      
        
      $response = $this->client->get('rest/access');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('panel::dashboard.access.index')->with('access',$entries)->with("access_active",'active');
    
    }


    public function createAccess(Request $request)
    {
      
      return view('panel::dashboard.access.create')->with("access_active",'active');
    }

    public function storeAccess(Request $request)
    {

      $payload = array('phone' => $request['phone'],'email' => $request['email'],'address' => $request['address']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createaccess', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getAccess' );
      }
    }



    public function editAccess(Request $request,$id)
    {
      $response = $this->client->get('rest/editaccess/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.access.edit')->with("id",$id)->with("cat",$cat)->with("access_active",'active');

        
    }

    public function updateAccess(Request $request,$id)
    {
      $payload = array('phone' => $request['phone'],'email' => $request['email'],'address' => $request['address']);

      $payload = json_encode($payload);
      
      $response = $this->client->post('rest/updateaccess/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getAccess' );
      }
    }
    public function destroyAccess(Request $request,$id)
    {

      
      $response = $this->client->post('rest/destroyaccess/'.$id, [
       'debug' => FALSE,
       'body' => '',
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getAccess' );
      }
    }








     public function indexSocial(Request $request)
    {

      
        
      $response = $this->client->get('rest/social');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('panel::dashboard.social.index')->with('social',$entries)->with("social_active",'active');
    
    }


    public function createSocial(Request $request)
    {
      
      return view('panel::dashboard.social.create')->with("social_active",'active');
    }

    public function storeSocial(Request $request)
    {

      $payload = array('telegram' => $request['telegram'],'instagram' => $request['instagram'],'linkedin' => $request['linkedin'],'aparat' => $request['aparat']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createsocial', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getSocial' );
      }
    }



    public function editSocial(Request $request,$id)
    {
      $response = $this->client->get('rest/editsocial/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.social.edit')->with("id",$id)->with("cat",$cat)->with("social_active",'active');

        
    }

    public function updateSocial(Request $request,$id)
    {
      $payload = array('telegram' => $request['telegram'],'instagram' => $request['instagram'],'linkedin' => $request['linkedin'],'aparat' => $request['aparat']);

      $payload = json_encode($payload);
      
      $response = $this->client->post('rest/updatesocial/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getSocial');
      }
    }
    public function destroySocial(Request $request,$id)
    {

      
      $response = $this->client->post('rest/destroysocial/'.$id, [
       'debug' => FALSE,
       'body' => '',
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getSocial' );
      }
    }







    public function indexNews(Request $request)
    {
        if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }


  //return $_SERVER["REMOTE_ADDR"];
     
      $response = $this->client->get('rest/news');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());
      return view('panel::dashboard.news.index')->with('news',$entries)->with("newss",'active');
    }


       public function createNews(Request $request)
    {
      $response = $this->client->get('rest/category');
      $cat = json_decode($response->getBody(),true);
      
      return view('panel::dashboard.news.create')->with('categories',$cat);
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
        return redirect()->route( 'panel.getNews' );
       }else{
        return redirect()->route( 'panel.getNews' );
       }




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
      return view('panel::dashboard.news.edit')->with("post",$post)->with("categories",$cat);
        
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
        return redirect()->route( 'panel.getNews' );
       }else{
        return redirect()->route( 'panel.getNews' );
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
      return redirect()->route( 'panel.getNews' );


    }



  public function indexCategory(Request $request)
    {

      if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }
        
      $response = $this->client->get('rest/category');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('panel::dashboard.category.index')->with('categories',$entries)->with('category_news','active');
        
    }



      


 public function createCategory(Request $request)
    {
      
      return view('panel::dashboard.category.create');
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
        return redirect()->route( 'panel.getCategory' );
      }
    }



    public function editCategory(Request $request,$id)
    {
      $response = $this->client->get('rest/editcategory/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.category.edit')->with("id",$id)->with("cat",$cat);

        
    }

    public function updateCategory(Request $request,$id)
    {
      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);
      
      $response = $this->client->post('rest/updatecategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getCategory' );
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
        return redirect()->route( 'panel.getCategory' );
      }
    }

























    public function indexKMS(Request $request)
    {
        if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }


  //return $_SERVER["REMOTE_ADDR"];
     
      $response = $this->client->get('rest/kms');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());
      return view('panel::dashboard.kms.index')->with('news',$entries)->with("kms_active",'active');
    }


       public function createKMS(Request $request)
    {
      $response = $this->client->get('rest/kmscategory');
      $cat = json_decode($response->getBody(),true);
      
      return view('panel::dashboard.kms.create')->with('categories',$cat);
    }

    /**
    * Store a newly created resource in storage.
    * 172.16.238.1:8000/api/v1/media
    * 172.16.238.1:8000/api/v1/posts
    * 172.16.238.1:8000/api/v1/authenticate
    */
    public function storeKMS(Request $request)
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

      $response = $this->client->request('POST','api/v1/kms', [
       
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
        return redirect()->route( 'panel.getKMS' );
       }else{
        return redirect()->route( 'panel.getKMS' );
       }




    }


 public function editKMS(Request $request,$id)
    {
      $response = $this->client->get('rest/kmscategory');
      $cat = json_decode($response->getBody(),true);
      
      $response = $this->client->get('api/v1/kms/'.$id, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $post = json_decode($response->getBody(),true);
      $post = $post['data'];
      return view('panel::dashboard.kms.edit')->with("post",$post)->with("categories",$cat);
        
    }

    public function updateKMS(Request $request,$id)
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

      $response = $this->client->request('POST','api/v1/kms/update/'.$id, [
       
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
        return redirect()->route( 'panel.getKMS' );
       }else{
        return redirect()->route( 'panel.getKMS' );
       }

    }


    public function destroyKMS(Request $request,$id)
    { 
      
      $response = $this->client->delete('api/v1/kms/'.$id, [
        'headers' => [
         
          'Authorization' => 'Bearer hxqRyNChPRUMcdVbMvZghMJ78VW59qWSGL5dPLXutlQp2inYnYpMqoJntuRX'
        ]
        
       ]);
      $news = json_decode($response->getBody(),true);
      return redirect()->route( 'panel.getKMS' );


    }

























  public function indexKMSCategory(Request $request)
    {

      if(auth()->user()->hasRole('moderator')) {
            return redirect('panel/users');
        }
        
      $response = $this->client->get('rest/kmscategory');
      $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


      return view('panel::dashboard.kmscategory.index')->with('categories',$entries)->with('kmscategory_active','active');
        
    }


 public function createKMSCategory(Request $request)
    {
      
      return view('panel::dashboard.kmscategory.create');
    }

    public function storeKMSCategory(Request $request)
    {

      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createkmscategory', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getKMSCategory' );
      }
    }



    public function editKMSCategory(Request $request,$id)
    {
      $response = $this->client->get('rest/editkmscategory/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.kmscategory.edit')->with("id",$id)->with("cat",$cat);

        
    }

    public function updateKMSCategory(Request $request,$id)
    {
      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);
      
      $response = $this->client->post('rest/updatekmscategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getKMSCategory' );
      }
    }
    public function destroyKMSCategory(Request $request,$id)
    {
      $payload = array('content' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/destroykmscategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getKMSCategory' );
      }
    }
















/**
 * Product Category
 */

public function indexProductCategory(Request $request)
{

  
    
  $response = $this->client->get('rest/productcategory');
  $news = json_decode($response->getBody(),true);

  $currentPage = LengthAwarePaginator::resolveCurrentPage();
  $col = new Collection($news);
  $perPage = 15;
  $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
  $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
  $entries->setPath($request->url());


  return view('panel::dashboard.productcategory.index')->with('categories',$entries)->with('product_category','active');

}



public function createProductCategory(Request $request)
    {
      
      return view('panel::dashboard.productcategory.create');
    }

    public function storeProductCategory(Request $request)
    {

      $payload = array('name' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/createproductcategory', [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getProductCategory' );
      }
    }



    public function editProductCategory(Request $request,$id)
    {
      $response = $this->client->get('rest/editproductcategory/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('panel::dashboard.productcategory.edit')->with("id",$id)->with("cat",$cat);

        
    }

    public function updateProductCategory(Request $request,$id)
    {
      $payload = array('name' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/updateproductcategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getProductCategory' );
      }
    }
    public function destroyProductCategory(Request $request,$id)
    {
      $payload = array('name' => $request['name']);

      $payload = json_encode($payload);

      
      $response = $this->client->post('rest/destroyproductcategory/'.$id, [
       'debug' => FALSE,
       'body' => $payload,
       'headers' => [
         'Content-Type' => 'application/json',
       ]
      ]);
      $body = $response->getBody()->getContents();
      if($body==200){
        return redirect()->route( 'panel.getProductCategory' );
      }
    }






/**
* Product
*/




public function indexProduct(Request $request)
{

  
    
  $response = $this->client->get('rest/product');
  $news = json_decode($response->getBody(),true);

  $currentPage = LengthAwarePaginator::resolveCurrentPage();
  $col = new Collection($news);
  $perPage = 15;
  $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
  $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
  $entries->setPath($request->url());


  return view('panel::dashboard.products.index')->with('products',$entries)->with('product_active','active');

}


public function createProduct(Request $request)
{
  $response = $this->client->get('rest/productcategory');
  $categories = json_decode($response->getBody(),true);
  
  return view('panel::dashboard.products.create')->with("categories",$categories);;
}

public function storeProduct(Request $request)
{

  $payload = array('name' => $request['name'],'description' => $request['post-ckeditor'],'category_id' => $request['category_id'],'posted_at' => date("Y-m-d H:i:s"));

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/createproduct', [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProduct' );
  }
}



public function editProduct(Request $request,$id)
{
  $response = $this->client->get('rest/editproduct/'.$id);
  $product = json_decode($response->getBody(),true);
  $response = $this->client->get('rest/productcategory');
  $categories = json_decode($response->getBody(),true);
  return view('panel::dashboard.products.edit')->with("id",$id)->with("product",$product)->with("categories",$categories);

    
}

public function updateProduct(Request $request,$id)
{
  $payload = array('name' => $request['name'],'description' => $request['post-ckeditor'],'category_id' => $request['category_id'],'posted_at'=>date("Y-m-d H:i:s"));

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/updateproduct/'.$id, [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProduct' );
  }
}
public function destroyProduct(Request $request,$id)
{
  $payload = array('name' => $request['name']);

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/destroyproduct/'.$id, [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProduct' );
  }
}










/**
* Product Price
*/





public function indexProductPrice(Request $request)
{

  
    
  $response = $this->client->get('rest/productprice');
  $news = json_decode($response->getBody(),true);

  $currentPage = LengthAwarePaginator::resolveCurrentPage();
  $col = new Collection($news);
  $perPage = 15;
  $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
  $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
  $entries->setPath($request->url());


  return view('panel::dashboard.productsprice.index')->with('products',$entries)->with('product_price_active',"active");

}


public function createProductPrice(Request $request)
{
  $response = $this->client->get('rest/product');
  $categories = json_decode($response->getBody(),true);
  return view('panel::dashboard.productsprice.create')->with("categories",$categories);;
}

public function storeProductPrice(Request $request)
{
  $response = $this->client->request('POST','api/v1/authenticate', [
    'form_params' => [
     'email' => 'darthvader@deathstar.ds',
     'password' => '4nak1n'
    ]
    
   ]);
   $body = json_decode($response->getBody()->getContents(),true);
   $author_id = $body['data']['id'];
   $request['max']=$this->convertEntoFaNum($request['max']);
   $request['min']=$this->convertEntoFaNum($request['min']);
   $average = ($request['max']+$request['min'])/2;

  $payload = array('author_id' => $author_id,'product_id' => $request['product_id'],'min' => $request['min'],'max' => $request['max'],'average' => $average,'posted_at'=>date("Y-m-d H:i:s"));

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/createproductprice', [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProductPrice' );
  }
}



public function editProductPrice(Request $request,$id)
{
  $response = $this->client->get('rest/editproductprice/'.$id);
  $product = json_decode($response->getBody(),true);
  $response = $this->client->get('rest/product');
  $categories = json_decode($response->getBody(),true);
  return view('panel::dashboard.productsprice.edit')->with("id",$id)->with("product",$product)->with("categories",$categories);

    
}

public function updateProductPrice(Request $request,$id)
{
  $response = $this->client->request('POST','api/v1/authenticate', [
    'form_params' => [
     'email' => 'darthvader@deathstar.ds',
     'password' => '4nak1n'
    ]
    
   ]);
   $body = json_decode($response->getBody()->getContents(),true);
   $author_id = $body['data']['id'];

  $average = ($request['max']+$request['min'])/2;
  $payload = array('author_id' => $author_id,'product_id' => $request['product_id'],'min' => $request['min'],'max' => $request['max'],'average' => $average,'posted_at'=>date("Y-m-d H:i:s"));

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/updateproductprice/'.$id, [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProductPrice' );
  }
}
public function destroyProductPrice(Request $request,$id)
{
  $payload = array('name' => $request['name']);

  $payload = json_encode($payload);

  
  $response = $this->client->post('rest/destroyproductprice/'.$id, [
   'debug' => FALSE,
   'body' => $payload,
   'headers' => [
     'Content-Type' => 'application/json',
   ]
  ]);
  $body = $response->getBody()->getContents();
  if($body==200){
    return redirect()->route( 'panel.getProductPrice' );
  }
}


     










    

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        return view('panel::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show()
    {
        return view('panel::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @return Response
     */
    public function edit()
    {
        return view('panel::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Request $request)
    {
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy()
    {
    }
}
