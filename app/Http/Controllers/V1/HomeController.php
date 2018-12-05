<?php

namespace App\Http\Controllers\V1;

use App\Models\Order;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use GuzzleHttp\Client;
use App\Models\Listing;
use App\Models\Widget;
use Location;
use Setting;
use MetaTag;
use LaravelLocalization;
use Theme;
use Illuminate\Support\Facades\View;

class HomeController extends Controller
{
    private $client;

   
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //$this->middleware('auth');
        $this->client=new Client(['base_uri' => 'http://172.16.238.1:8000']);
    }

   

    public function redirect(Request $request)
    {
        return redirect('/');
    }


    public function indexAbout(Request $request)
    {
        $response = $this->client->get('rest/about');
        $about = json_decode($response->getBody(),true);

        return view('v1.about')->with('about',$about)->with('aboutus_active','active');
    }

    public function indexContact(Request $request)
    {
        $response = $this->client->get('rest/access');
        $contact = json_decode($response->getBody(),true);
      
      return view('v1.contact')->with("contactus_active",'active')->with('contact',$contact)->with('alert');
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
        $response = $this->client->get('rest/access');
        $contact = json_decode($response->getBody(),true);
      
       return view('v1.contact')->with("contactus_active",'active')->with('contact',$contact)->with('alert','ok');
      }
    }

    public function newsbyslug(Request $request,$slug)
    {
        $response = $this->client->get('rest/newsbyslug/'.$slug);
        $news = json_decode($response->getBody(),true);


        return view('v1.newsbyslug')->with('news',$news)->with('news_active','active');
    }
    public function news(Request $request)
    {
        $response = $this->client->get('rest/newslist');
        $news = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($news);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());


        return view('v1.news')->with('news',$entries)->with('news_active','active');
    }
    public function kmsbyslug(Request $request,$slug)
    {
        $response = $this->client->get('rest/kmsbyslug/'.$slug);
        $kms = json_decode($response->getBody(),true);


        return view('v1.kmsbyslug')->with('kms',$kms)->with('kms_active','active');
    }
    public function kms(Request $request)
    {
        $response = $this->client->get('rest/kmslist');
        $kms = json_decode($response->getBody(),true);

      $currentPage = LengthAwarePaginator::resolveCurrentPage();
      $col = new Collection($kms);
      $perPage = 15;
      $currentPageSearchResults = $col->slice(($currentPage - 1) * $perPage, $perPage)->all();
      $entries = new LengthAwarePaginator($currentPageSearchResults, count($col), $perPage);
      $entries->setPath($request->url());

        return view('v1.kms')->with('kms',$entries)->with('kms_active','active');
    }
    public function pricebyslug(Request $request,$slug)
    {
        $response = $this->client->get('rest/pricebyslug/'.$slug);
        $price = json_decode($response->getBody(),true);


        return view('v1.pricebyslug')->with('price',$price)->with('price_active','active');
    }



    public function price(Request $request)
    {

        $response = $this->client->get('rest/latestprice');
        $price = json_decode($response->getBody(),true);

        $kab = array(array());
        $plus = array(array());
        $lohmen = array(array());
        $ras = array(array());

        $nine = array(array());
        $zeroten = array(array());
        $ten = array(array());
        $zeroeleven = array(array());
        $eleven = array(array());
        $zerotwelve = array(array());
        $tweleve = array(array());
        $zerothirteen = array(array());
        $thirteen = array(array());
        

        $morghzende = array(array());
        $i = 0;
        foreach ($price['data'] as $p) {
            $i++;
            if ($p['product']['name']=="مرغ زنده"){
                $morghzende[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="کاب"){
                $kab[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="لوهمن"){
                $lohmen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="راس"){
                $ras[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="پلاس"){
                $plus[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="09.5"){
                $nine[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="10"){
                $zeroten[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="10.5"){
                $ten[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="11"){
                $zeroeleven[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="11.5"){
                $eleven[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="12"){
                $zerotwelve[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="12.5"){
                $tweleve[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="13"){
                $zerothirteen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="13"){
                $thirteen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }
            


        }
        



        

 return view('v1.price')->with('morghzende',$morghzende)->with('kab',$kab)->with('plus',$plus)->with('ras',$ras)->with('lohmen',$lohmen)->with('nine',$nine)->with('zeroten',$zeroten)->with('ten',$ten)->with('zeroeleven',$zeroeleven)->with('eleven',$eleven)->with('zerotwelve',$zerotwelve)->with('tweleve',$tweleve)->with('zerothirteen',$zerothirteen)->with('thirteen',$thirteen)->with('price_active','active');      
    }



    public function index(Request $request)
    {
        //read good news

        $response = $this->client->get('rest/popularnews');
        $pnews = json_decode($response->getBody(),true);
        $response = $this->client->get('rest/latestnews');
        $lnews = json_decode($response->getBody(),true);
        $response = $this->client->get('rest/latestkms');
        $lkms = json_decode($response->getBody(),true);
        $response = $this->client->get('rest/latestpopularkms');
        $pkms = json_decode($response->getBody(),true);
        $response = $this->client->get('rest/latestevent');
        $levent = json_decode($response->getBody(),true);


        $response = $this->client->get('rest/latestprice');
        $price = json_decode($response->getBody(),true);

        $kab = array(array());
        $plus = array(array());
        $lohmen = array(array());
        $ras = array(array());

        $nine = array(array());
        $zeroten = array(array());
        $ten = array(array());
        $zeroeleven = array(array());
        $eleven = array(array());
        $zerotwelve = array(array());
        $tweleve = array(array());
        $zerothirteen = array(array());
        $thirteen = array(array());
        

        $morghzende = array(array());
        $i = 0;
        foreach ($price['data'] as $p) {
            $i++;
            if ($p['product']['name']=="مرغ زنده"){
                $morghzende[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="کاب"){
                $kab[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="لوهمن"){
                $lohmen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="راس"){
                $ras[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="پلاس"){
                $plus[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="09.5"){
                $nine[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="10"){
                $zeroten[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="10.5"){
                $ten[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="11"){
                $zeroeleven[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="11.5"){
                $eleven[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="12"){
                $zerotwelve[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="12.5"){
                $tweleve[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="13"){
                $zerothirteen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }else if($p['product']['name']=="13"){
                $thirteen[$i]= array('name' => $p['product']['name'],'average' => $p['average'],'posted_at' => $p['posted_at'] );
                
            }
            


        }
        



        

 return view('v1.index')->with('pnews',$pnews)->with('lnews',$lnews)->with('lkms',$lkms)->with('pkms',$pkms)->with('levent',$levent)->with('morghzende',$morghzende)->with('kab',$kab)->with('plus',$plus)->with('ras',$ras)->with('lohmen',$lohmen)->with('nine',$nine)->with('zeroten',$zeroten)->with('ten',$ten)->with('zeroeleven',$zeroeleven)->with('eleven',$eleven)->with('zerotwelve',$zerotwelve)->with('tweleve',$tweleve)->with('zerothirteen',$zerothirteen)->with('thirteen',$thirteen)->with('index_active','active');		
    }

}

