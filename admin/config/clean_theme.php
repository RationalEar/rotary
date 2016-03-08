<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
* Name: modern theme Config
*
* 
*/
$config['theme']['name'] = 'Clean Bootstrap 3';
$config['theme']['menu'] = 'megamenu';
$config['theme']['tree'] = TRUE;
$config['theme']['login_link'] = '#quicklogin';
$config['theme']['login_option'] = ' data-toggle="modal"';
// 'bootstrap.min'=>array('href'=>'bootstrap.min', 'rel'=>'stylesheet', 'type'=>'text/css', 'media'=>'screen' )
	//'font-awesome' , 'uniform.default'
$config['theme']['styles'] = 
	array( 'bootstrap.min', 'customize-template' );
									//, 'simplePagination' 'icon-style' 'auctions' 'jquery-ui-1.10.1.min',
$config['theme']['scripts'] = array( 'bootstrap.min' );
									// 'auctions', 'jquery.simplePagination','jquery-ui-1.10.1.min',, 'jquery.tweet' 'superfish'

$config['theme']['topmenu'] = array( 8, 64, 117, 6, 3, 30, 31, 36, 4 );


									
$config['pagination'] = array(
		'cur_tag_open' => '<li class="active"><a>',
		'cur_tag_close' => '</a></li>',
		'prev_tag_open' => '<li>',
		'prev_tag_close' => '</li>',
		'next_tag_open' => '<li>',
		'next_tag_close' => '</li>',
		'num_tag_open' => '<li>',
		'num_tag_close' => '</li>',
		'next_link' => 'more &raquo;',
		'prev_link' => '&laquo; prev',
		'first_link' => 'First',
		'first_tag_open' => '<li>',
		'first_tag_close' => '</li>',
		'last_link' => 'Last',
		'last_tag_open' => '<li>',
		'last_tag_close' => '</li>',
	);

$config['error_class'] = 'alert alert-warning alert-dismissable';
$config['success_class'] = 'alert alert-success alert-dismissable';
$config['info_class'] = 'alert alert-info alert-dismissable';

/* End of file modern_theme.php */
/* Location: ./site/config/modern_theme.php */
