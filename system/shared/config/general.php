<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if( strcmp('localhost',$_SERVER['SERVER_NAME'])!=0 ) $config['live'] = FALSE;
else $config['live'] = TRUE; 

$config['admin_panels'] = array( 'admin' );
$config['site-name'] = 'Rotary Club';
$config['address'] = 'No. 60 Colquhoun Street, Cnr Five Ave, Harare';
$config['phone'] = '+263 123 456 789';
$config['meetings'] = 'Meeting time not set';
$config['site-email'] = 'email@example.com';
$config['no-reply'] = 'no-reply@example.com';
$config['year-founded'] = 2012;
$config['author'] = 'BIT Technologies';
$config['author-url'] = 'http://www.bittechnologyz.com';

$config['facebook'] = 'https://www.facebook.com';
$config['twitter'] = 'https://twitter.com';
$config['google'] = 'https://plus.google.com';

