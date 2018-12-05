<?php
namespace App\Http\ViewComposers;
use Illuminate\View\View;
use \App\Http\Repository\FooterRepository;
class FooterComposer
{
    public $contact = [];
    public $social = [];
    public $lnews;
    /**
     * Create a movie composer.
     *
     *  @param FooterRepository $movie
     *
     * @return void
     */
    public function __construct(FooterRepository $con)
    {
        $this->contact = $con->getContact();
        $this->social = $con->getSocial();
        $this->lnews = $con->getLatestNews();
    }
    /**
     * Bind data to the view.
     *
     * @param  View  $view
     * @return void
     */
    public function compose(View $view)
    {
        $view->with('contact', end($this->contact))->with('social', end($this->social))->with('lnews', $this->lnews);
    }
}