<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Al
{

	function __construct() 
	{
		$this->ci = &get_instance();
		$this->ci->load->model('user_model');
		$this->ci->load->model('article_model');
		$this->ci->data['nav_element'] = 'articles';
		$this->ci->data['section'] = 'index';
		$this->ci->data['innertitle'] = 'Site Pages and Articles';
	}

	public function index()
	{
		$this->_process_form();
		$this->ci->pc->page_control('article_list', 10 );
		$continue = $this->_process_get();
		
		if($continue)
		{
			$count = array( 'count'=>TRUE);
			$function = 'get_articles';
			$paginate = $this->ci->pc->paginate($count, $function, 'article_model');
			
			$args = array( 'start'=>$paginate['start'], 'limit'=>$paginate['limit'], 'sort'=>'at_date_posted desc' );
			$count['count'] = NULL;
			$args = array_merge($args, $count);
			
			$this->ci->data['articles'] = $this->ci->article_model->get_articles( $args );
		}
		
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}

	public function about($args=array())
	{
	}

	public function new_article()
	{
		$this->_process_form();
		
		$this->ci->data['ckeditor'] = TRUE;
		$this->ci->data['scripts'][] = 'ajaxupload';
		$this->ci->data['scripts'][] = 'images';
		
		$this->ci->data['sections'] = $this->ci->article_model->get_sections();
		
		$this->ci->data['section'] = 'new_article';
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}

	public function news()
	{
		$this->_process_form();
		$this->ci->pc->page_control('news_list', 10 );
		$continue = $this->_process_get();
		
		if($continue)
		{
			$where = array( 'at_section'=>5 );
			$count = array( 'where'=>$where, 'count'=>1 );
			
			$paginate = $this->ci->pc->paginate($count, 'get_articles', 'article_model');
			$args = array_merge( $paginate, array( 'where'=>$where, 'sort'=>'at_id desc' ) );
			$this->ci->data['articles'] = $this->ci->article_model->get_articles( $args );
			$this->ci->data['innertitle'] = 'News';
		}
		
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}

	public function projects()
	{
		$this->_process_form();
		$this->ci->pc->page_control('projects_list', 10 );
		$continue = $this->_process_get();
		
		if($continue)
		{
			$where = array( 'at_section'=>6 );
			$count = array( 'where'=>$where, 'count'=>1 );
			
			$paginate = $this->ci->pc->paginate($count, 'get_articles', 'article_model');
			$args = array_merge( $paginate, array( 'where'=>$where, 'sort'=>'at_id desc' ) );
			$this->ci->data['articles'] = $this->ci->article_model->get_articles( $args );
			$this->ci->data['innertitle'] = 'Projects';
		}
		
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}

	public function reports()
	{
		$this->_process_form();
		$this->ci->pc->page_control('projects_list', 10 );
		$continue = $this->_process_get();
		
		if($continue)
		{
			$where = array( 'at_section'=>10 );
			$count = array( 'where'=>$where, 'count'=>1 );
			
			$paginate = $this->ci->pc->paginate($count, 'get_articles', 'article_model');
			$args = array_merge( $paginate, array( 'where'=>$where, 'sort'=>'at_id desc' ) );
			$this->ci->data['articles'] = $this->ci->article_model->get_articles( $args );
			$this->ci->data['innertitle'] = 'Reports';
		}
		
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}

	public function gallery($id=FALSE)
	{
		$this->_process_form();
		$this->ci->pc->page_control('gallery_list', 10 );
		$continue = $this->_process_get();
		
		if($continue)
		{
			if( $id > 0 )
			{
				$this->ci->data['section'] = 'gallery_images';
				$this->ci->data['innertitle'] = 'Gallery Images';
				$this->ci->data['uploader'] = 'fine';
				$where = array( 'at_section'=>11, 'at_id'=>$id );
				$this->ci->data['gallery'] = $this->ci->article_model->get_articles(  array( 'where'=>$where, 'one'=>TRUE ) );
				$this->ci->data['images'] = $this->ci->article_model->get_gallery(  array( 'at_id'=>$id ) );
			}
			else
			{
				$where = array( 'at_section'=>11 );
				$count = array( 'where'=>$where, 'count'=>1 );
				$paginate = $this->ci->pc->paginate($count, 'get_articles', 'article_model');
				$args = array_merge( $paginate, array( 'where'=>$where, 'sort'=>'at_id desc' ) );
				$this->ci->data['articles'] = $this->ci->article_model->get_articles( $args );
				$this->ci->data['innertitle'] = 'Gallery';
			}
		}
		
		$this->ci->load->view( "{$this->ci->data['theme']}/articles.tpl", $this->ci->data );
	}
	

	/****** PROCESS FORM DATA ************/
	public function _process_form($r=FALSE)
	{
		$name = $this->ci->input->post('form_name');
		$action = $this->ci->input->post('form_type');
		if( !is_null($name) && !is_null($action) )
		{
			$this->ci->load->library('form_validation');
			
			if( $name == 'article' && $action == 'insert' )
			{
				$this->ci->form_validation->set_rules( 'text', 'Article Body', 'required' );
				$this->ci->form_validation->set_rules( 'title', 'Title', 'required' );
				if( $this->ci->form_validation->run() )
				{
					$error = $this->ci->article_model->post_article();
					sem($error);
					if(!$r) $r = 'articles';
					if( !$error['error'] )
						redirect( $r );
				}
			}
			elseif( $name == 'article' && $action == 'update' )
			{
				$this->ci->form_validation->set_rules( 'text', 'Article Body', 'required' );
				$this->ci->form_validation->set_rules( 'title', 'Title', 'required' );
				$this->ci->form_validation->set_rules( 'id', 'Article ID', 'required|numeric' );
				if( $this->ci->form_validation->run() )
				{
					$error = $this->ci->article_model->update_article();
					sem($error);
					if(!$r) $r = current_url();
					if( !$error['error'] )
						redirect( $r );
				}
			}
			elseif( $name == 'article' && $action == 'delete' )
			{
				$this->ci->form_validation->set_rules( 'confirm_delete', 'Yes I\'m sure', 'required' );
				$this->ci->form_validation->set_rules( 'id', 'Article ID', 'required|numeric' );
				if( $this->ci->form_validation->run() )
				{
					$id = $this->ci->input->get('id');
					$error = $this->ci->article_model->delete_article($id);
					sem($error);
					if(!$r) $r = current_url();
					if( !$error['error'] )
						redirect( $r );
				}
			}
			elseif( $name == 'gallery_images' && $action == 'insert' )
			{
				$this->ci->form_validation->set_rules( 'id', 'Gallery ID', 'required|numeric|integer' );
				if( $this->ci->form_validation->run() )
				{
					$error = $this->ci->article_model->update_gallery_images();
					sem($error);
					if(!$r) $r = current_url();
					if( !$error['error'] )
						redirect( $r );
				}
			}
		}
		//else sem('no form data found');
		return 0;
	}
	
	
	public function _process_get()
	{
		$continue = TRUE;
		$action = $this->ci->input->get('action');
		if($p = $this->ci->input->get('p'));else $p = FALSE;		// p = property to toggle
		if($v = $this->ci->input->get('v'));else $v=FALSE;		// v = value used for toggle operations
		if($id = $this->ci->input->get('id'));else $id=FALSE;		// id of item to change
		if( $action )
		{
			if( $action=='add_user' )
			{
				$this->ci->data['add_user'] = TRUE;
				$this->ci->data['innertitle'] = 'Add User';
				$this->ci->data['groups'] = $this->ci->user_model->get_groups();
				$continue = FALSE;
			}
			elseif( $action=='edit_article' )
			{
				if( $id = $this->ci->input->get('id') )
				{
					$this->ci->data['article'] = $this->ci->article_model->get_articles( array('id'=>$id) );
					$this->ci->data['sections'] = $this->ci->article_model->get_sections();
					$this->ci->data['section'] = 'edit_article';
					$this->ci->data['innertitle'] = 'Edit Article';
					$this->ci->data['ckeditor'] = TRUE;
					$this->ci->data['scripts'][] = 'ajaxupload';
					$this->ci->data['scripts'][] = 'images';
					$continue = FALSE;
				}
			}
			elseif( $action=='remove_account' )
			{
				if( $id = $this->ci->input->get('id') )
				{
					$this->ci->data['account'] = $this->ci->user_model->get_users( array('id'=>$id) );
					$this->ci->data['section'] = 'remove_account';
					$continue = FALSE;
				}
			}
			elseif( $action=='toggle_state' && is_numeric($id) && $p )
			{
				$id = $this->ci->input->get('id');
				$data = array('id'=>$id, 'state'=>$v, 'property'=>$p);
				$e = $this->ci->article_model->toggle_state( $data );
				sem($e);
				redirect( current_url() );
				$continue = TRUE;
			}
			elseif( $action=='delete_article' && is_numeric($id) )
			{
				$this->ci->data['article'] = $this->ci->article_model->get_articles( array('id'=>$id) );
				$this->ci->data['section'] = 'delete_article';
				$continue = FALSE;
			}
		}
		return $continue;
	}
}
