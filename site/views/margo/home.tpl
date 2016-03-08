<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$this->load->view("$theme/common/header.tpl");?>

	<!-- Start Home Page Slider -->
	<section id="home">
		<!-- Carousel -->
		<div id="main-slide" class="carousel slide" data-ride="carousel">

		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#main-slide" data-slide-to="0" class="active"></li>
			<li data-target="#main-slide" data-slide-to="1"></li>
			<li data-target="#main-slide" data-slide-to="2"></li>
		</ol>
		<!--/ Indicators end-->

		<!-- Carousel inner -->
		<div class="carousel-inner">
			<div class="item active">
			<img class="img-responsive" src="images/slider/bg1.jpg" alt="slider">
			<div class="slider-content">
				<div class="col-md-12 text-center">
				<h2 class="animated2">
								<span>Welcome to <strong class="wite-text">Rotaract</strong></span>
								</h2>
				<h3 class="animated3 white">
								<span><?php echo $this->config->item('site-name')?></span>
								</h3>
				<p class="animated4"><a href="<?php echo site_url('about')?>" class="slider btn btn-system btn-large">Get Started</a>
				</p>
				</div>
			</div>
			</div>
			<!--/ Carousel item end -->
			<div class="item">
			<img class="img-responsive" src="images/slider/bg1.jpg" alt="slider">
			<div class="slider-content">
				<div class="col-md-12 text-center">
				<h2 class="animated4">
								<span><strong>Service</strong> above self</span>
							</h2>
				<h3 class="animated5">
								<span>One Profits Most Who Serves Best</span>
							</h3>
				<p class="animated6"><a href="<?php echo site_url('about')?>" class="slider btn btn-system btn-large">Learn More</a>
				</p>
				</div>
			</div>
			</div>
			<!--/ Carousel item end -->
			<div class="item">
			<img class="img-responsive" src="images/slider/bg1.jpg" alt="slider">
			<div class="slider-content">
				<div class="col-md-12 text-center">
				<h2 class="animated7 white">
								<span>The <strong>4-Way Test</strong></span>
							</h2>
				<h3 class="animated8 white">
								<span>Of the things we think, say or do</span>
							</h3>
				<div class="">
					<a class="animated4 slider btn btn-system btn-large btn-min-block" href="<?php echo site_url('about/i/3/the-four-way-test')?>">Learn More</a>
				</div>
				</div>
			</div>
			</div>
			<!--/ Carousel item end -->
		</div>
		<!-- Carousel inner end-->

		<!-- Controls -->
		<a class="left carousel-control" href="#main-slide" data-slide="prev">
			<span><i class="fa fa-angle-left"></i></span>
		</a>
		<a class="right carousel-control" href="#main-slide" data-slide="next">
			<span><i class="fa fa-angle-right"></i></span>
		</a>
		</div>
		<!-- /carousel -->
	</section>
	<!-- End Home Page Slider -->

	<?php 
		$this->load->view("$theme/home/services.tpl");
		$this->load->view("$theme/home/popular.tpl");
	?>
	<br clear="all"><br clear="all">
	
	<!-- Start Purchase Section -->
	<div class="section purchase">
		<div class="container">

		<!-- Start Video Section Content -->
		<div class="section-video-content text-center">

			<!-- Start Animations Text -->
			<h1 class="fittext wite-text uppercase tlt">
				<span class="texts">
					<span>What</span>
				</span>
				would it take to change the world?
			</h1>
			<!-- End Animations Text -->

			<p class="wite-text" style="font-size:18px;margin-bottom:20px;">
				Rotaract brings together adults ages 18-30 to take action in their communities, develop their leadership and professional skills, and have fun. 
				Tell us a little about yourself so we can connect with you right away.
			</p>

			<!-- Start Buttons -->
			<?php echo anchor( 'about', '<i class="fa fa-book"></i> Learn More', 'class="btn-system btn-large"' );?>
			<?php echo anchor( current_url().'#contact-widget', '<i class="fa fa-phone"></i> Get In Touch', 'class="btn-system btn-large btn-wite"' );?>
		</div>
		<!-- End Section Content -->

		</div>
		<!-- .container -->
	</div>
	<!-- End Purchase Section -->

	<br clear="all"><br clear="all">

	<!-- Start Testimonials Section -->
	<div class="container">
		<div class="row">
			<div class="col-sm-7">
				<!-- Start Recent Posts Carousel -->
				<div class="latest-posts">
					<h4 class="classic-title"><span>About Rotary</span></h4>
					<div class="latest-posts-classic">
						<!-- Posts 1 -->
						<div class="post-row item">
							<div class="post-content testimonials">
								<p><span>R</span>otary is a worldwide organization of business and professional leaders that provides humanitarian service and 
									encourages high ethical standards in all vocations.
								</p>
								<p><span>R</span>otary's main objective is service — in the community, in the workplace, and around the globe. The 1.2 million 
									Rotarians who make up more than 34,000 Rotary clubs in nearly every country in the world share a dedication to the ideal of 
									Service Above Self.
								</p>
								<p><span>R</span>otary clubs are open to people of all cultures and ethnicities and are not affiliated with any political or 
									religious organizations.
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- End latest posts -->
			</div>
			<!-- col-sm-7 -->

			<div class="col-md-5">
				<!-- Classic Heading -->
				<h4 class="classic-title"><span>What Makes Rotary</span></h4>
				<!-- Start Testimonials Carousel -->
				<ul class="nav nav-tabs" id="myTab">
					<li class="active"><a data-toggle="tab" href="#home">Rotary Foundation</a></li>
					<li class=""><a data-toggle="tab" href="#service">Service &amp; Fellowship</a></li>
					<li class=""><a data-toggle="tab" href="#programs">Programs</a></li>
				</ul>
				
				<div class="tab-content" id="myTabContent">
					<div id="home" class="tab-pane fade active in">
						<p>
							The Rotary Foundation of Rotary International is a non-profit corporation that promotes world understanding through humanitarian 
							service and educational and cultural exchanges.
						</p>
					</div>
					<div id="programs" class="tab-pane fade">
						<p>
							The family of Rotary extends beyond individual Rotarians and Rotary clubs to include other service-minded people who help with the 
							organization's work. Groups such as Rotaract, Interact, and Rotary Community Corps serve side by side with sponsor clubs, using their 
							diverse skills to improve the quality of life in their communities.
						</p>
					</div>
					<div id="service" class="tab-pane fade">
						<p>
							The Rotary motto Service Above Self conveys the humanitarian spirit of the organization’s more than 1.2 million members. Strong 
							fellowship among Rotarians and meaningful community and international service projects characterize Rotary worldwide.
						</p>
					</div>
				</div>
			</div>
			<!-- End col-md-5 -->
		</div>
		<!-- row -->
	</div>
	<!-- container -->
	<!-- End Testimonials Section -->


	<!-- Start Team Member Section -->
	<div class="section" style="background:#fff;">
		<div class="container">

		<!-- Start Big Heading -->
		<div class="big-title text-center" data-animation="fadeInDown" data-animation-delay="01">
			<h1>
				<?php echo $this->config->item('site-name');?>
			</h1>
		</div>
		<!-- End Big Heading -->

		<!-- Some Text -->
		<p class="text-center">
			<?php echo $aboutus['at_summary'];?>		
		</p>


		<!-- Start Team Members -->
		<div class="row">
			<?php foreach( $about as $k=>$v ):
				$link = "{$v['sc_value']}/i/{$v['at_id']}/{$v['at_segment']}";
				$a = array( 'class'=>'thumbnail', 'title'=>$v['at_title'] );
				$img = array( 'src'=>"images/articles/250x180/{$v['at_image']}", 'alt'=>$v['at_title'] );
			?>
			<!-- Start Memebr 1 -->
			<div class="col-md-3 col-sm-6 col-xs-12" data-animation="fadeIn" data-animation-delay="<?php echo $k+3?>">
				<div class="team-member modern">
					<!-- Memebr Photo, Name & Position -->
					<div class="member-photo">
						<?php echo anchor( $link, img($img));?>
						<div class="member-name">
							<?php echo anchor( $link, $v['at_title'], 'class="wite-text"');?>
						</div>
					</div>
					<!-- Memebr Words -->
					<div class="member-info">
						<p>
							<?php echo $v['at_summary'];?>
						</p>
					</div>
				</div>
			</div>
			<!-- End Memebr 1 -->
			<?php endforeach;?>


		</div>
		<!-- End Team Members -->

		</div>
		<!-- .container -->
	</div>
	<!-- End Team Member Section -->


	

<?php $this->load->view("$theme/common/footer.tpl");?>
