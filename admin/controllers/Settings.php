<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends CI_Controller
{

	function __construct() 
	{
		parent::__construct();
		$this->authorize->validate_user();
		$this->load->model('user_model');
		$this->load->model('article_model');
		$this->data['nav_element'] = 'articles';
		$this->data['section'] = 'index';
		$this->load->library('al');
	}

	public function index()
	{
		$this->load->view( "{$this->data['theme']}/settings.tpl", $this->data );
	}

	public function user_groups()
	{
		$this->data['section'] = 'user_groups';
		$this->pc->page_control('user_groups_list');
		if( $this->_process_get() )
		{
			$count = array( 'table'=>'user_groups', 'count'=>TRUE );
			$paginate = $this->pc->paginate( $count, 'get_groups', 'user_model' );
			$this->data['groups'] = $this->user_model->get_groups( $paginate );
		}
		
		$this->load->view("{$this->data['theme']}/settings.tpl", $this->data);
	}
	
	public function register()
	{
		$this->data['section'] = 'register';
		$this->load->view("{$this->data['theme']}/register.tpl", $this->data);
	}


	private function _process_get()
	{
		$continue = TRUE;
		$action = $this->input->get('action');
		
		if($action)
		{
			if( $action=='add_group' )
			{
				$this->data['section'] = 'add_group';
				$this->data['groups'] = $this->user_model->get_groups();
				$continue = FALSE;
			}
			elseif( $action == 'edit_group' && $id = $this->input->get('id') )
			{
				$this->data['group'] = $this->user_model->get_groups( array('id'=>$id) );
				$this->data['groups'] = $this->user_model->get_groups();
				$this->data['section'] = 'edit_group';
				$continue = FALSE;
			}
			elseif( $action == 'delete_group' && $id = $this->input->get('id') )
			{
				$this->data['group'] = $this->user_model->get_groups( array('id'=>$id) );
				$this->data['section'] = 'delete_group';
				$continue = FALSE;
			} 
		}
		return $continue;
	}

}
