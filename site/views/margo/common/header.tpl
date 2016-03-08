<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!DOCTYPE html>
<!-- saved from url=(0050)http://wbpreview.com/previews/WB0653692/index.html -->
<html lang="en"><!--<![endif]-->

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta name="viewport" content="width=100%, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta name="author" content="BIT Technologies">
	<link rel="icon" href="<?php echo base_url().'images/fav.ico' ?>" type="image/ico">
	<link rel="shortcut icon" href="<?php echo base_url().'images/fav.ico' ?>" type="image/ico">
	<title>
		<?php if(isset($title)) echo $title.' - '; echo $this->config->item('site-name');?>
	</title>
	
	<?php 
		if(isset($description)) echo meta( 'description', $description );
		if(isset($description)) echo meta( 'keywords', $keywords );
		$this->carabiner->display('css');
	?>
	<!--[if IE 8]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>
<!-- Full Body Container boxed-page -->
<div class="boxed-page">
	<!-- Start Header Section -->
	<div class="hidden-header"></div>
	<header class="clearfix">

		<!-- Start Top Bar -->
		<div class="top-bar">
			<div class="container">
				<div class="row">
					<div class="col-md-7">
						<!-- Start Contact Info -->
						<ul class="contact-details">
							<?php 
								if( $this->flexi_auth->is_logged_in() ):
									echo '<li>'.anchor( 'account', "{$user_data['first_name']} {$user_data['last_name']}").'</li>';
									if($this->flexi_auth->is_admin()):
										echo '<li>'.anchor( base_url('admin'), 'Admin Panel' ).'</li>';
									endif;
									echo '<li>'.anchor( 'account/logout', 'Logout' ).'</li>';
								else:
									echo '<li>'.anchor( 'account/login', 'Login').'</li>';
									echo '<li>'.anchor( 'account/register', 'Create Account').'</li>';
								endif;
							?>
						</ul>
						<!-- End Contact Info -->
					</div>
					<!-- .col-md-7 -->
					<div class="col-md-5">
						<!-- Start Social Links -->
						<ul class="social-list">
							<li>
								<?php echo anchor( $this->config->item('facebook'), '<i class="fa fa-facebook"></i>', 
									'class="facebook itl-tooltip" data-placement="bottom" title="Facebook"' );
								?>
							</li>
							<li>
								<?php echo anchor( $this->config->item('twitter'), '<i class="fa fa-twitter"></i>', 
									'class="twitter itl-tooltip" data-placement="bottom" title="Twitter"' );
								?>
							</li>
							<li>
								<?php echo anchor( $this->config->item('google'), '<i class="fa fa-google-plus"></i>', 
									'class="google itl-tooltip" data-placement="bottom" title="Google Plus"' );
								?>
							</li>
							<li>
								<a class="dribbble itl-tooltip" data-placement="bottom" title="Dribble" 
									href="#"><i class="fa fa-dribbble"></i>
								</a>
							</li>
							<li>
								<a class="linkdin itl-tooltip" data-placement="bottom" title="Linkedin" 
									href="#"><i class="fa fa-linkedin"></i>
								</a>
							</li>
							<li>
								<a class="flickr itl-tooltip" data-placement="bottom" title="Flickr" 
									href="#"><i class="fa fa-flickr"></i>
								</a>
							</li>
							<li>
								<a class="tumblr itl-tooltip" data-placement="bottom" title="Tumblr" 
									href="#"><i class="fa fa-tumblr"></i>
								</a>
							</li>
							<li>
								<a class="instgram itl-tooltip" data-placement="bottom" title="Instagram" 
									href="#"><i class="fa fa-instagram"></i>
								</a>
							</li>
							<li>
								<a class="vimeo itl-tooltip" data-placement="bottom" title="vimeo" 
									href="#"><i class="fa fa-vimeo-square"></i>
								</a>
							</li>
							<li>
								<a class="skype itl-tooltip" data-placement="bottom" title="Skype" 
									href="#"><i class="fa fa-skype"></i>
								</a>
							</li>
						</ul>
						<!-- End Social Links -->
					</div>
					<!-- .col-md-5 -->
				</div>
				<!-- .row -->
			</div>
			<!-- .container -->
		</div>
		<!-- End Top Bar -->
		
		<?php $this->load->view("$theme/common/manu.tpl");?>
		<?php $this->load->view("$theme/common/error.tpl");?>
	</header>
	<!-- End Header Section -->
