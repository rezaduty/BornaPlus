<?php

Route::group(['as' => 'panel.', 'prefix' => 'panel', 'middleware' => ['web', 'role:admin'], 'namespace' => '\Admin'], function()
{
    Route::get('/dashboard', 'DashboardController@index');



Route::get('/dashboard/about', 'DashboardController@indexAbout')->name('getAbout'); 
        Route::get('/dashboard/addabout', 'DashboardController@createAbout')->name('addAbout'); 
        Route::post('/dashboard/storeabout', 'DashboardController@storeAbout')->name('storeAbout'); 
        Route::get('/dashboard/destroyabout/{title}', 'DashboardController@destroyAbout')->name('destoryAbout'); 
        Route::get('/dashboard/editabout/{title}', 'DashboardController@editAbout')->name('editAbout'); 
        Route::post('/dashboard/updateabout/{title}', 'DashboardController@updateAbout')->name('updateAbout'); 


        Route::get('/dashboard/contact', 'DashboardController@indexContact')->name('getContact'); 
        Route::get('/dashboard/addcontact', 'DashboardController@createContact')->name('addContact');
        Route::post('/dashboard/storecontact', 'DashboardController@storeContact')->name('storeContact'); 
        Route::get('/dashboard/editcontact/{id}', 'DashboardController@editContact')->name('editContact'); 
        Route::post('/dashboard/updatecontact/{id}', 'DashboardController@updateContact')->name('updateContact'); 
        Route::get('/dashboard/destroycontact/{id}', 'DashboardController@destroyContact')->name('destoryContact'); 



        Route::get('/dashboard/social', 'DashboardController@indexSocial')->name('getSocial'); 
        Route::get('/dashboard/addsocial', 'DashboardController@createSocial')->name('addSocial');
        Route::post('/dashboard/storesocial', 'DashboardController@storeSocial')->name('storeSocial'); 
        Route::get('/dashboard/editsocial/{id}', 'DashboardController@editSocial')->name('editSocial'); 
        Route::post('/dashboard/updatesocial/{id}', 'DashboardController@updateSocial')->name('updateSocial'); 
        Route::get('/dashboard/destroysocial/{id}', 'DashboardController@destroySocial')->name('destorySocial'); 



        Route::get('/dashboard/access', 'DashboardController@indexAccess')->name('getAccess'); 
        Route::get('/dashboard/addaccess', 'DashboardController@createAccess')->name('addAccess');
        Route::post('/dashboard/storeaccess', 'DashboardController@storeAccess')->name('storeAccess'); 
        Route::get('/dashboard/editaccess/{id}', 'DashboardController@editAccess')->name('editAccess'); 
        Route::post('/dashboard/updateaccess/{id}', 'DashboardController@updateAccess')->name('updateAccess'); 
        Route::get('/dashboard/destroyaccess/{id}', 'DashboardController@destroyAccess')->name('destoryAccess'); 



Route::get('/dashboard/news', 'DashboardController@indexNews')->name('getNews'); 
        Route::get('/dashboard/addnews', 'DashboardController@createNews')->name('addNews'); 
        Route::post('/dashboard/storenews', 'DashboardController@storeNews')->name('storeNews'); 
        Route::get('/dashboard/destroynews/{title}', 'DashboardController@destroyNews')->name('destoryNews'); 
        Route::get('/dashboard/editnews/{title}', 'DashboardController@editNews')->name('editNews'); 
        Route::post('/dashboard/updatenews/{title}', 'DashboardController@updateNews')->name('updateNews'); 


        Route::get('/dashboard/category', 'DashboardController@indexCategory')->name('getCategory'); 
        Route::get('/dashboard/addcategory', 'DashboardController@createCategory')->name('addCategory');
        Route::post('/dashboard/storecategory', 'DashboardController@storeCategory')->name('storeCategory'); 
        Route::get('/dashboard/editcategory/{id}', 'DashboardController@editCategory')->name('editCategory'); 
        Route::post('/dashboard/updatecategory/{id}', 'DashboardController@updateCategory')->name('updateCategory'); 
        Route::get('/dashboard/destroycategory/{id}', 'DashboardController@destroyCategory')->name('destoryCategory'); 



Route::get('/dashboard/kms', 'DashboardController@indexKMS')->name('getKMS'); 
        Route::get('/dashboard/addkms', 'DashboardController@createKMS')->name('addKMS'); 
        Route::post('/dashboard/storekms', 'DashboardController@storeKMS')->name('storeKMS'); 
        Route::get('/dashboard/destroykms/{title}', 'DashboardController@destroyKMS')->name('destoryKMS'); 
        Route::get('/dashboard/editkms/{title}', 'DashboardController@editKMS')->name('editKMS'); 
        Route::post('/dashboard/updatekms/{title}', 'DashboardController@updateKMS')->name('updateKMS'); 


        Route::get('/dashboard/kmscategory', 'DashboardController@indexKMSCategory')->name('getKMSCategory'); 
        Route::get('/dashboard/addkmscategory', 'DashboardController@createKMSCategory')->name('addKMSCategory');
        Route::post('/dashboard/storekmscategory', 'DashboardController@storeKMSCategory')->name('storeKMSCategory'); 
        Route::get('/dashboard/editkmscategory/{id}', 'DashboardController@editKMSCategory')->name('editKMSCategory'); 
        Route::post('/dashboard/updatekmscategory/{id}', 'DashboardController@updateKMSCategory')->name('updateKMSCategory'); 
        Route::get('/dashboard/destroykmscategory/{id}', 'DashboardController@destroyKMSCategory')->name('destoryKMSCategory'); 




        /**
         * Product Categories
         *  */ 
        Route::get('/dashboard/productcategory', 'DashboardController@indexProductCategory')->name('getProductCategory'); 
        Route::get('/dashboard/addproductcategory', 'DashboardController@createProductCategory')->name('addProductCategory'); 
        Route::post('/dashboard/storeproductcategory', 'DashboardController@storeProductCategory')->name('storeProductCategory'); 
        Route::get('/dashboard/destroyproductcategory/{id}', 'DashboardController@destroyProductCategory')->name('destoryProductCategory'); 
        Route::get('/dashboard/editproductcategory/{id}', 'DashboardController@editProductCategory')->name('editProductCategory'); 
        Route::post('/dashboard/updateproductcategory/{id}', 'DashboardController@updateProductCategory')->name('updateProductCategory'); 



        /** 
         * Product
        */

        Route::get('/dashboard/product', 'DashboardController@indexProduct')->name('getProduct'); 
        Route::get('/dashboard/addproduct', 'DashboardController@createProduct')->name('addProduct'); 
        Route::post('/dashboard/storeproduct', 'DashboardController@storeProduct')->name('storeProduct'); 
        Route::get('/dashboard/destroyproduct/{id}', 'DashboardController@destroyProduct')->name('destoryProduct'); 
        Route::get('/dashboard/editproduct/{id}', 'DashboardController@editProduct')->name('editProduct'); 
        Route::post('/dashboard/updateproduct/{id}', 'DashboardController@updateProduct')->name('updateProduct'); 




        /**
         * Product Price
         */




        Route::get('/dashboard/productprice', 'DashboardController@indexProductPrice')->name('getProductPrice'); 
        Route::get('/dashboard/addproductprice', 'DashboardController@createProductPrice')->name('addProductPrice'); 
        Route::post('/dashboard/storeproductprice', 'DashboardController@storeProductPrice')->name('storeProductPrice'); 
        Route::get('/dashboard/destroyproductprice/{id}', 'DashboardController@destroyProductPrice')->name('destoryProductPrice'); 
        Route::get('/dashboard/editproductprice/{id}', 'DashboardController@editProductPrice')->name('editProductPrice'); 
        Route::post('/dashboard/updateproductprice/{id}', 'DashboardController@updateProductPrice')->name('updateProductPrice'); 







    Route::get('panel', 'PanelController@index');
    Route::resource('listings', 'ListingsController');
    Route::resource('categories', 'CategoriesController');
    Route::resource('users', 'UsersController');
    Route::resource('pages', 'PagesController');
    Route::resource('menu', 'MenuController');
    Route::any('/settings/remove', 'SettingsController@remove')->name('settings.remove');
    Route::resource('settings', 'SettingsController');
    Route::resource('orders', 'OrdersController');
    Route::resource('home', 'HomeController');
    Route::resource('addons', 'AddonsController');
    Route::get('/addon/{id}/toggle', 'AddonsController@toggle');
    Route::resource('themes', 'ThemesController');
    Route::get('/theme/{id}/toggle', 'ThemesController@toggle');
    Route::resource('pricing-models', 'PricingModelsController');
    Route::resource('fields', 'FieldsController');

});

Route::group(['as' => 'panel.', 'prefix' => 'panel', 'middleware' => ['web', 'role:admin|moderator'], 'namespace' => '\Admin'], function()
{
    Route::get('/', 'PanelController@index');
    Route::resource('users', 'UsersController');
});