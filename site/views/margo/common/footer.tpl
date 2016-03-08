<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

	<!-- Start Footer Section -->
	<footer>
		<div class="container">
		<div class="row footer-widgets">

			<!-- Start Contact Widget -->
			<div class="col-md-3 col-xs-12">
				<div class="footer-widget contact-widget">
					<h4>
						<?php $img = array( 'src'=>'images/logor50.png', 'class'=>'img-responsive', 'alt'=>$this->config->item('site-name').' logo' );
							echo anchor( base_url(), img($img) );
						?>
					</h4>
					<p>
						<?php 
							echo $required_content['aboutus']['at_summary'].'<br>';
							echo anchor( 'about', 'Read More &raquo;', 'class="wite-text"' );
						?>
					</p>
				</div>
			</div>
			<!-- Start Subscribe & Social Links Widget -->
			<div class="col-md-3 col-xs-12">
				<div class="footer-widget mail-subscribe-widget" id="contact-widget">
					<h4>Get in touch<span class="head-line"></span></h4>
					<p>Want to find out more about our club, leave us a message and our secretary will get back to you as soon as possible.</p>
					<?php echo form_open( current_url(), 'class="subscribe form-horizontal"' );?>
						<div class="form-group">
							<div class="input-group input-group-sm">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input class="form-control input-sm" type="text" name="name" title="Full Name" placeholder="Full Name" required>
							</div>
						</div>
						<div class="form-group">
							<div class="input-group input-group-sm">
								<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
								<input class="form-control input-sm" name="email" type="email" placeholder="Email Address" title="Email Address" required>
							</div>
						</div>
						<div class="form-group">
							<textarea class="form-control input-sm" name="message" placeholder="Your Message" title="Your Message" required></textarea>
						</div>
						<div class="form-group">
							<input type="submit" class="btn-system" value="Send" name="contact_us">
							<input type="hidden" name="form_name" value="contact">
							<input type="hidden" name="form_type" value="insert">
						</div>
					</form>
				</div>
			</div>
			<!-- .col-md-3 -->
			<!-- End Subscribe Widget -->


			<!-- Start Twitter Widget -->
			<div class="col-md-3 col-xs-12">
			<div class="footer-widget twitter-widget">
				<h4>Twitter Feed<span class="head-line"></span></h4>
				<a class="twitter-timeline" href="https://twitter.com/RotHreCentral" data-widget-id="699986841924194305" 
					data-chrome="nofooter noborders" data-tweet-limit="2">
					Tweets by @RotHreCentral
				</a>
				<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
			</div>
			</div>
			<!-- .col-md-3 -->
			<!-- End Twitter Widget -->
			
			<div class="col-md-3 col-xs-12">
				<div class="footer-widget social-widget">
					<h4>Follow Us<span class="head-line"></span></h4>
					<ul class="social-icons">
						<li>
							<a class="facebook" href="<?php echo $this->config->item('facebook');?>"><i class="fa fa-facebook"></i></a>
						</li>
						<li>
							<a class="twitter" href="<?php echo $this->config->item('twitter');?>"><i class="fa fa-twitter"></i></a>
						</li>
						<li>
							<a class="google" href="<?php echo $this->config->item('google');?>"><i class="fa fa-google-plus"></i></a>
						</li>
					</ul>
					<ul>
						<li><span>Phone Number:</span> <?php echo $this->config->item('phone');?></li>
						<li><span>Email:</span> <?php echo safe_mailto( $this->config->item('site-email') );?></li>
						<li><span>Address:</span> <?php echo $this->config->item('address');?></li>
					</ul>
				</div>
			</div>
			<!-- .col-md-3 -->
			<!-- End Contact Widget -->


		</div>
		<!-- .row -->

		<!-- Start Copyright -->
		<div class="copyright-section">
			<div class="row">
				<div class="col-md-6">
					<p>&copy; <?php echo $this->config->item('year-founded').' - '.date('Y').' '.$this->config->item('site-name');?> - All Rights Reserved 
						&nbsp;&nbsp;&nbsp;
						<?php echo anchor( $this->config->item('author-url'), $this->config->item('author') );?>
					</p>
				</div>
				<!-- .col-md-6 --
				<div class="col-md-6">
					<ul class="footer-nav">
					<li><a href="#">Sitemap</a>	</li>
					<li><a href="#">Privacy Policy</a></li>
					<li><a href="#">Contact</a>	</li>
					</ul>
				</div>
				<!-- .col-md-6 -->
			</div>
			<!-- .row -->
		</div>
		<!-- End Copyright -->

		</div>
	</footer>
	<!-- End Footer Section -->


	</div>
	<!-- End Full Body Container -->

	<!-- Go To Top Link -->
	<a href="#" class="back-to-top"><i class="fa fa-angle-up"></i></a>

	<!-- 
	<div id="loader">
	<div class="spinner">
		<div class="dot1"></div>
		<div class="dot2"></div>
	</div>
	</div>
	 -->
<?php 
$this->carabiner->display('js');

if( isset($scripts) ):
	if( is_array($scripts) ):
	//$scripts = array_unique($scripts);
	foreach( $scripts as $n=>$f ):
			if(is_array($f)):
				if($f['echo']):
					echo '<script>';
					$this->load->file("scripts/$n.js");
					echo '</script>';
				endif;
			else:
				echo '<script src="'.base_url().'scripts/'.$f.'.js"></script>';
			endif;
	endforeach;
	endif;
endif;

$this->sc->display('js');

if( isset($theme_scripts) ):
	if( is_array($theme_scripts) ):
	$theme_scripts = array_unique($theme_scripts);
	foreach( $theme_scripts as $f ):
		echo '<script src="'.base_url().'site/views/'.$theme.'/js/'.$f.'.js"></script>';
	endforeach;
	endif;
endif;

if( isset($print_scripts) ):
	if( is_array($print_scripts) ):
	echo '<script>';
	foreach( $print_scripts as $f ):
		echo $f." \n";
	endforeach;
	echo '</script>';
	endif;
endif;
?>

<?php if( substr_compare( base_url(), 'http://localhost', 0, 16) !=0 ):
	$this->load->view("$theme/common/analytics.tpl");
endif;?>

</body>
</html>
