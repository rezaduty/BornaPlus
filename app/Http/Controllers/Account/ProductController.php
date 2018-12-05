<?php


namespace App\Http\Controllers\Account;

use App\Http\Controllers\Controller;

use App\Models\User;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;


class ProductController extends Controller
{
   
    private $client;
    

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->client=new Client(['base_uri' => 'http://172.16.238.1:8000']);
        $this->middleware('auth');
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


  return view('account.products.index')->with('products',$entries);

}


public function createProduct(Request $request)
{
  $response = $this->client->get('rest/productcategory');
  $categories = json_decode($response->getBody(),true);
  
  return view('account.products.create')->with("categories",$categories);;
}

public function storeProduct(Request $request)
{

  $payload = array('name' => $request['name'],'category_id' => $request['category_id'],'posted_at' => date("Y-m-d H:i:s"));

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
    return redirect()->route( 'account.getProduct' );
  }
}



public function editProduct(Request $request,$id)
{
  $response = $this->client->get('rest/editproduct/'.$id);
  $product = json_decode($response->getBody(),true);
  $response = $this->client->get('rest/productcategory');
  $categories = json_decode($response->getBody(),true);
  return view('account.products.edit')->with("id",$id)->with("product",$product)->with("categories",$categories);

    
}

public function updateProduct(Request $request,$id)
{
  $payload = array('name' => $request['name'],'category_id' => $request['category_id'],'posted_at'=>date("Y-m-d H:i:s"));

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
    return redirect()->route( 'account.getProduct' );
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
    return redirect()->route( 'account.getProduct' );
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


  return view('account.productsprice.index')->with('products',$entries);

}


public function createProductPrice(Request $request)
{
  $response = $this->client->get('rest/product');
  $categories = json_decode($response->getBody(),true);
  return view('account.productsprice.create')->with("categories",$categories);;
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
    return redirect()->route( 'account.getProductPrice' );
  }
}



public function editProductPrice(Request $request,$id)
{
  $response = $this->client->get('rest/editproductprice/'.$id);
  $product = json_decode($response->getBody(),true);
  $response = $this->client->get('rest/product');
  $categories = json_decode($response->getBody(),true);
  return view('account.productsprice.edit')->with("id",$id)->with("product",$product)->with("categories",$categories);

    
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
    return redirect()->route( 'account.getProductPrice' );
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
    return redirect()->route( 'account.getProductPrice' );
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


  return view('account.productcategory.index')->with('categories',$entries);

}

    public function createProductCategory(Request $request)
    {
      
      return view('account.productcategory.create');
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
        return redirect()->route( 'account.getProductCategory' );
      }
    }



    public function editProductCategory(Request $request,$id)
    {
      $response = $this->client->get('rest/editproductcategory/'.$id);
      $cat = json_decode($response->getBody(),true);
      return view('account.productcategory.edit')->with("id",$id)->with("cat",$cat);

        
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
        return redirect()->route( 'account.getCategory' );
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
        return redirect()->route( 'account.getProductCategory' );
      }
    }

    

}
