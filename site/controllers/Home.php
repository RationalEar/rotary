<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller
{

	function __construct()
	{
		parent::__construct();
		$this->authorize->validate_user();
		$this->load->model('article_model');
		$this->data['menu'] = 'home';
		$this->data['rotary_theme'] = $this->article_model->get_month_theme();
	}

	public function index()
	{
		$where = array( 'at_enabled'=>1, 'at_featured'=>1, 'at_section'=>1 );
		
		$this->data['about'] = $this->article_model->get_articles( array( 'where'=>$where ) );
		
		$where = array( 'at_permalink'=>1, 'at_section'=>1 );
		$args = array( 'where'=>$where, 'one'=>1, 'enabled'=>1 );
			
		$this->data['aboutus'] = $this->article_model->get_articles( $args );
		
		$select = 'at_id, at_summary, at_title, at_segment, at_date_posted, at_image, at_show_main_image';
		$where = array( 'at_section'=>5 );
		$args = array( 'where'=>$where, 'sort'=>'at_date_posted desc', 'limit'=>6, 'select'=>$select );
		$this->data['recent_articles'] = $this->article_model->get_articles($args);
		
		$select = 'at_id, at_summary, at_title, at_segment, at_date_posted, at_image, at_show_main_image';
		$where = array( 'at_section'=>5 );
		$args = array( 'where'=>$where, 'sort'=>'at_hits desc', 'limit'=>6, 'select'=>$select );
		$this->data['popular_articles'] = $this->article_model->get_articles($args);
		
		$this->load->view( "{$this->data['theme']}/home.tpl", $this->data );
	}

	public function search()
	{
		$q = trim($this->input->get('q'));
		$q = strip_tags($q);
		$q = $this->security->xss_clean($q);
		$this->data['search_term'] = $q;
		if( is_string($q) && strlen($q)>0 )
		{
			$this->pc->page_control( 'search', 10 );
			$like = array( 'at_keywords'=>$q ); //'at_section'=>5
			$count = array( 'like'=>$like, 'count'=>1 );
			$paginate = $this->pc->paginate($count, 'get_articles', 'article_model');
			
			$args = array_merge( $paginate, array( 'like'=>$like, 'sort'=>'at_date_posted desc' ) );
			$this->data['articles'] = $articles = $this->article_model->get_articles( $args );
				
				$select = 'at_id, at_summary, at_title, at_segment, at_date_posted, at_image, at_show_main_image';
				$where = array( 'at_section'=>5 );
				$args = array( 'sort'=>'at_date_posted desc', 'limit'=>5, 'select'=>$select, 'where'=>$where );
				$this->data['recent_articles'] = $this->article_model->get_articles($args);
				
				$select = 'at_keywords';
				$where = array( 'at_section'=>5 );
				$args = array( 'sort'=> array('at_id'=>'RANDOM'), 'limit'=>5, 'select'=>$select, 'where'=>$where );
				$tags = $this->article_model->get_articles($args);
				$tags1 = array();
				foreach( $tags as $t )
				{
					$t1 = explode( ',', $t['at_keywords'] );
					foreach( $t1 as $t2 )
					{
						if( strlen($t2)>3 ) $tags1[] = $t2;
					}
				}
				$this->data['tags'] = array_unique($tags1);

			$this->data['section'] = 'article';
			$this->load->view("{$this->data['theme']}/home/search.tpl", $this->data );
		}
		else
		{
			sem( 'You need to type something in the search box.' );
			redirect( 'news' );
		}
	}
	
}
