<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
/*
Route::get('/', function () {
    return view('welcome');
});

Route::get('/test', function () {
    return view('welcome');
});
*/



include "admin.php";

Route::get('/cp', function () {
    if(env('DEMO_PANEL')) {
        \Auth::loginUsingId(1, true);
        return redirect("/panel");
    }
});




Route::group(['prefix' => LaravelLocalization::setLocale(), 'middleware' => 'jailBanned'], function()
{
/*
	Auth::routes();
    Route::get('email-verification', 'Auth\EmailVerificationController@sendEmailVerification')->name('email-verification.send');
    Route::get('email-verification/error', 'Auth\EmailVerificationController@getVerificationError')->name('email-verification.error');
    Route::get('email-verification/check/{token}', 'Auth\EmailVerificationController@getVerification')->name('email-verification.check');

    Route::get('/', 'HomeController@index')->name('home');
    Route::get('/browse', 'BrowseController@listings')->name('browse');

    Route::get('/pages/{slug}', 'PageController@index')->name('page');
	Route::get('/contact', 'ContactController@index')->name('contact');
	Route::post('/contact', 'ContactController@postIndex')->name('contact.post');

	Route::get('/profile/{user}', 'ProfileController@index')->name('profile'); //PROFILE
	Route::get('/profile/{user}/follow', 'ProfileController@follow')->name('profile.follow'); //PROFILE

	//LISTINGS
	Route::group(['prefix' => 'listing'], function()
	{
		Route::get('/{listing}/{slug}', 'ListingController@index')->name('listing');
		Route::get('/{listing}/{slug}/spotlight', 'ListingController@spotlight')->middleware('auth.ajax')->name('listing.spotlight');
		Route::get('/{listing}/{slug}/verify', 'ListingController@verify')->middleware('auth.ajax')->name('listing.verify');
		Route::get('/{listing}/{slug}/star', 'ListingController@star')->middleware('auth.ajax')->name('listing.star');
		Route::get('/{listing}/{slug}/edit', 'ListingController@edit')->name('listing.edit');
		Route::any('/{id}/update', 'ListingController@update')->name('listing.update');

	});
*/
Auth::routes();
    Route::get('email-verification', 'Auth\EmailVerificationController@sendEmailVerification')->name('email-verification.send');
    Route::get('email-verification/error', 'Auth\EmailVerificationController@getVerificationError')->name('email-verification.error');
    Route::get('email-verification/check/{token}', 'Auth\EmailVerificationController@getVerification')->name('email-verification.check');

    Route::get('/', 'HomeController@index')->name('home');
	Route::get('/browse', 'BrowseController@listings')->name('browse');

	 Route::get('/pages/{slug}', 'PageController@index')->name('page');
	Route::get('/contact', 'ContactController@index')->name('contact');
	Route::post('/contact', 'ContactController@postIndex')->name('contact.post');

	Route::get('/profile/{user}', 'ProfileController@index')->name('profile'); //PROFILE
	Route::get('/profile/{user}/follow', 'ProfileController@follow')->name('profile.follow'); //PROFILE

	//LISTINGS
	Route::group(['prefix' => 'listing'], function()
	{
		Route::get('/{listing}/{slug}', 'ListingController@index')->name('listing');
		Route::get('/{listing}/{slug}/spotlight', 'ListingController@spotlight')->middleware('auth.ajax')->name('listing.spotlight');
		Route::get('/{listing}/{slug}/verify', 'ListingController@verify')->middleware('auth.ajax')->name('listing.verify');
		Route::get('/{listing}/{slug}/star', 'ListingController@star')->middleware('auth.ajax')->name('listing.star');
		Route::get('/{listing}/{slug}/edit', 'ListingController@edit')->name('listing.edit');
		Route::any('/{id}/update', 'ListingController@update')->name('listing.update');

	});


Route::group(['as' => 'v1.', 'namespace' => 'V1'], function()
{
	
    
    Route::get('/news', 'HomeController@news')->name('news');
    Route::get('/news/{slug}', 'HomeController@newsbyslug')->name('newsbyslug');
    Route::get('/kms/', 'HomeController@kms')->name('kms');
    Route::get('/kms/{slug}', 'HomeController@kmsbyslug')->name('kmsbyslug');
    Route::get('/price', 'HomeController@price')->name('price');
    Route::get('/price/{slug}', 'HomeController@pricebyslug')->name('pricebyslug');
    Route::get('/aboutus', 'HomeController@indexAbout')->name('about');
    Route::get('/contactus', 'HomeController@indexContact')->name('contact');
    Route::post('/contactus/thanks', 'HomeController@storeContact')->name('storeContact');



});



	//ACCOUNT
	Route::group(['middleware' => ['auth', 'isVerified'], 'prefix' => 'account', 'as' => 'account.', 'namespace' => 'Account'], function()
	{
		Route::get('/', function () {
			return redirect(route('account.edit_profile.index'));
		});
		Route::resource('change_password', 'PasswordController');
		Route::resource('edit_profile', 'ProfileController');






		
		Route::get('news', 'NewsController@indexNews')->name('getNews'); 
		Route::get('addnews', 'NewsController@createNews')->name('addNews'); 
		Route::post('storenews', 'NewsController@storeNews')->name('storeNews'); 
		Route::get('destroynews/{title}', 'NewsController@destroyNews')->name('destoryNews'); 
		Route::get('editnews/{title}', 'NewsController@editNews')->name('editNews'); 
		Route::post('updatenews/{title}', 'NewsController@updateNews')->name('updateNews'); 


		Route::get('category', 'NewsController@indexCategory')->name('getCategory'); 
		Route::get('addcategory', 'NewsController@createCategory')->name('addCategory');
		Route::post('storecategory', 'NewsController@storeCategory')->name('storeCategory'); 
		Route::get('editcategory/{id}', 'NewsController@editCategory')->name('editCategory'); 
		Route::post('updatecategory/{id}', 'NewsController@updateCategory')->name('updateCategory'); 
		Route::get('destroycategory/{id}', 'NewsController@destroyCategory')->name('destoryCategory'); 










		/**
		 * Product Categories
		 *  */ 
		Route::get('productcategory', 'ProductController@indexProductCategory')->name('getProductCategory'); 
		Route::get('addproductcategory', 'ProductController@createProductCategory')->name('addProductCategory'); 
		Route::post('storeproductcategory', 'ProductController@storeProductCategory')->name('storeProductCategory'); 
		Route::get('destroyproductcategory/{id}', 'ProductController@destroyProductCategory')->name('destoryProductCategory'); 
		Route::get('editproductcategory/{id}', 'ProductController@editProductCategory')->name('editProductCategory'); 
		Route::post('updateproductcategory/{id}', 'ProductController@updateProductCategory')->name('updateProductCategory'); 

		/** 
		 * Product
		*/

		Route::get('product', 'ProductController@indexProduct')->name('getProduct'); 
		Route::get('addproduct', 'ProductController@createProduct')->name('addProduct'); 
		Route::post('storeproduct', 'ProductController@storeProduct')->name('storeProduct'); 
		Route::get('destroyproduct/{id}', 'ProductController@destroyProduct')->name('destoryProduct'); 
		Route::get('editproduct/{id}', 'ProductController@editProduct')->name('editProduct'); 
		Route::post('updateproduct/{id}', 'ProductController@updateProduct')->name('updateProduct'); 



		/**
		 * Product Price
		 */




		Route::get('productprice', 'ProductController@indexProductPrice')->name('getProductPrice'); 
		Route::get('addproductprice', 'ProductController@createProductPrice')->name('addProductPrice'); 
		Route::post('storeproductprice', 'ProductController@storeProductPrice')->name('storeProductPrice'); 
		Route::get('destroyproductprice/{id}', 'ProductController@destroyProductPrice')->name('destoryProductPrice'); 
		Route::get('editproductprice/{id}', 'ProductController@editProductPrice')->name('editProductPrice'); 
		Route::post('updateproductprice/{id}', 'ProductController@updateProductPrice')->name('updateProductPrice'); 






		Route::resource('purchase-history', 'PurchaseHistoryController');
		Route::resource('favorites', 'FavoritesController');

		Route::resource('listings', 'ListingsController');
        Route::resource('orders', 'OrdersController');
        Route::resource('bank-account', 'BankAccountController');

        Route::get('paypal/connect', 'PayPalController@connect')->name('paypal.connect');
        Route::get('paypal/callback', 'PayPalController@callback')->name('paypal.callback');

	});

	//REQUIRES AUTHENTICATION
	Route::group(['middleware' => ['auth', 'isVerified']], function () {

		//INBOX
		Route::resource('inbox', 'InboxController')->middleware('talk'); //Inbox

		//CREATE LISTING
		Route::resource('create', 'CreateController');
        Route::any('/create/{listing}/session', 'CreateController@session')->name('create.session');
        Route::get('/create/{listing}/images', 'CreateController@images')->name('create.images');
        Route::get('/create/{listing}/additional', 'CreateController@additional')->name('create.additional');
        Route::get('/create/{listing}/pricing', 'CreateController@pricing')->name('create.pricing');
        Route::get('/create/{listing}/times', 'CreateController@getTimes')->name('create.times');
        Route::post('/create/{listing}/times', 'CreateController@postTimes')->name('create.times');

        Route::post('/create/{listing}/uploads', 'CreateController@upload')->name('create.upload');
        Route::delete('/create/{listing}/image/{uuid?}', 'CreateController@deleteUpload')->name('create.delete-image');

        #Route::delete('/uploads/delete/{id}', array('as' => 'upload', 'uses' => 'CreateController@deleteUpload'))->name('create.delete-image');;
		#Route::get('/listings/{id}/session', array('as' => 'create', 'uses' => 'CreateController@session'));

		//CHECKOUT
		Route::get('/checkout/{listing}', 'CheckoutController@index')->name('checkout');
		Route::any('/checkout/process/{listing}', 'CheckoutController@process')->name('checkout.process');
		#Route::any('/checkout/test', 'CheckoutController@test')->name('checkout.test');
		#Route::resource('stripe', 'StripeController');
		#Route::any('/stripe/connect', 'StripeController@connect')->name('stripe.connect');

        Route::any('/paypal/{listing}/start', 'PaypalController@start')->name('paypal.start');
        Route::any('/paypal/cancel', 'PaypalController@cancel')->name('paypal.cancel');
        Route::any('/paypal/callback', 'PaypalController@callback')->name('paypal.callback');
        Route::any('/paypal/confirm', 'PaypalController@confirm')->name('paypal.confirm');
        #Route::any('/paypal/create_agreement', 'PaypalController@create_agreement')->name('paypal.create_agreement');


    });

    //REQUIRES AUTHENTICATION
    Route::group(['middleware' => ['auth']], function () {

        Route::get('email-verification', 'Auth\EmailVerificationController@index')->name('email-verification.index');
        Route::get('resend-verification', 'Auth\EmailVerificationController@resend')->name('email-verification.resend');
        Route::get('email-verified', 'Auth\EmailVerificationController@verified')->name('email-verification.verified');

    });

	Route::get('login/facebook', 'Auth\LoginController@redirectToProvider');
	Route::get('login/facebook/callback', 'Auth\LoginController@handleProviderCallback');


});

#errors
Route::get('/suspended',function(){
    return 'Sorry something went wrong.';
})->name('error.suspended');

