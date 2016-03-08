<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
* Name: modern theme Config
*
* 
*/
$config['theme']['name'] = 'Margo Bootstrap 3.3.6';

$config['theme']['styles'] = 
	array( 'bootstrap.min', 'font-awesome.min', 'slicknav', 'style', 'responsive', 'animate', 'colors/red', 'lightgallery.min', 'custom' );
									//, 'simplePagination' 'icon-style' 'auctions' 'jquery-ui-1.10.1.min',
$config['theme']['scripts'] = 
	array( 'jquery.migrate', 'modernizrr', 'bootstrap.min', 'jquery.fitvids', 'owl.carousel.min', 'nivo-lightbox.min', 
		'jquery.isotope.min', 'jquery.appear', 'count-to', 'jquery.textillate', 'jquery.lettering', 'jquery.easypiechart.min', 
		'jquery.nicescroll.min', 'jquery.parallax', 'mediaelement-and-player', 'jquery.slicknav', 'script' );

									
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

/* End of file margo_theme.php */
/* Location: ./site/config/margo_theme.php */
