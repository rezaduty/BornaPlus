<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use App\Models\Listing;
use App\Models\Widget;
use Location;
use Setting;
use MetaTag;
use LaravelLocalization;
use Theme;
use Illuminate\Support\Collection;
use GuzzleHttp\Client;

class HomeController extends Controller
{
    private $client;

    protected $category_id;

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

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function postIndex(Request $request) {
        $url = http_build_query($request->except('_token'));
        return redirect('/home?'.$url);
    }

    public function redirect(Request $request)
    {
        return redirect('/');
    }

    public function index(Request $request)
    {
        /*if(!setting('custom_homepage')) {
            return app('App\Http\Controllers\BrowseController')->listings($request);
        }*/

        $current_locale = LaravelLocalization::getCurrentLocale();
        $data['widgets'] = Widget::where('locale', $current_locale)->orderBy('position', 'ASC')->get();
        $data['show_search'] = false;

        MetaTag::set('title', Setting::get('home_title'));
        MetaTag::set('description', Setting::get('home_description'));

        //return view('home.index', $data);
		





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
