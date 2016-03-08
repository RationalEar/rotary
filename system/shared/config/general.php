<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if( strcmp('localhost',$_SERVER['SERVER_NAME'])!=0 ) $config['live'] = FALSE;
else $config['live'] = TRUE; 

$config['admin_panels'] = array( 'admin' );
$config['site-name'] = 'Rotaract Club of Harare Central';
$config['address'] = 'No. 60 Colquhoun Street, Cnr Five Ave, Harare';
$config['phone'] = '+263 734 910 305';
$config['meetings'] = 'Every Fortnight on Fridays, 1730 - 1900hrs at the Rotary Centre';
$config['site-email'] = 'secretary@rotaracthararecentral.org';
$config['no-reply'] = 'no-reply@rotaracthararecentral.org';
$config['year-founded'] = 2012;
$config['author'] = 'BIT Technologies';
$config['author-url'] = 'http://www.bittechnologyz.com';

$config['facebook'] = 'https://www.facebook.com/groups/123892992084/';
$config['twitter'] = 'https://twitter.com/RotHreCentral';
$config['google'] = 'https://plus.google.com';


// Site title shown as 'from' header on emails.
$config['email']['site_title'] = $config['site-name'];

// Reply email shown as 'from' header on emails.
$config['email']['reply_email'] = $config['site-email'];
