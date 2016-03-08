<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>About Us</h2>
				<p><?php echo $this->config->item('site-name');?></p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>About Us</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- End Page Banner -->

<br clear="all"><br clear="all">

<!-- Start Content -->
<div class="content">
	<div class="container">
		<div class="page-content">
			<div class="row">
				<div class="col-sm-8">
					<!-- Classic Heading -->
					<h4 class="classic-title">
						<span><?php echo $aboutus['at_title'];?></span>
					</h4>
					<!-- Some Text -->
					<div class="about-us">
						<?php echo html_entity_decode($aboutus['at_text']);?>
					</div>
				</div>

				<div class="col-sm-4 sidebar right-sidebar">
					<!-- Start Touch Slider --
					<div class="touch-slider" data-slider-navigation="true" data-slider-pagination="false">
						<?php foreach( $about as $k=>$v ):
							$link = "{$v['sc_value']}/i/{$v['at_id']}/{$v['at_segment']}";
							$a = array( 'class'=>'thumbnail', 'title'=>$v['at_title'] );
							$img = array( 'src'=>"images/articles/250x180/{$v['at_image']}", 'alt'=>$v['at_title'] );
						?>
							<div class="item">
								<?php echo anchor( $link, img($img), $a );?>
								<p>
									<h4>
										<?php echo anchor( $link, $v['at_title'] );?>
									</h4>
									<?php echo $v['at_summary'];?>
								</p>
							</div>
						<?php endforeach;?>
					</div>
					<!-- End Touch Slider -->
					
					<!-- Popular Posts widget -->
				<div class="widget widget-popular-posts">
					<h4>
						Rotary International <span class="head-line"></span>
					</h4>
					<ul>
						<?php foreach( $rotary as $k=>$v ):
							$link = site_url( "{$v['sc_value']}/{$v['at_id']}/{$v['at_segment']}" );
							$img = "images/articles/100x75/{$v['at_image']}";
							$f = ( file_exists($img) && is_file($img) );
						?>
							<li>
								<?php if( $v['at_show_main_image'] && $f ):
									$imgt = array( 'src'=>$img, 'class'=>'img' );
									$cl = 90;
									$st = 'style="margin-bottom:0;"';
								?>
									<div class="widget-thumb">
										<?php echo anchor( $link, img($imgt), array('title'=>$v['at_title']) );?>
									</div>
								<?php else: 
										$cl = 110;
										$st='';
									endif;?>
								<div class="widget-content">
									<h5 <?php echo $st?>>
										<?php echo anchor( $link, character_limiter($v['at_title'],$cl), array('title'=>$v['at_title']) );?>
									</h5>
									<span>
										<?php echo character_limiter($v['at_summary'],$cl);?>
									</span>
								</div>
								<div class="clearfix"></div>
							</li>
						<?php endforeach;?>
					</ul>
				</div>
					
				</div>
				<!-- col-sm-4 -->
			</div>
			<!-- row -->

			<!-- Divider -->
			<div class="hr1" style="margin-bottom:50px;"></div>

			<!-- Classic Heading -->
			<h4 class="classic-title"><span>Our Team</span></h4>

			<!-- Start Team Members -->
			<div class="row">
				<?php foreach($leadership as $k=>$v):
					$link = "about/leadership/{$v['at_id']}/{$v['at_segment']}";
				?>
					<!-- Start Memebr 1 -->
					<div class="col-md-3 col-sm-6 col-xs-12">
						<div class="team-member">
							<!-- Memebr Photo, Name & Position -->
							<div class="member-photo">
								<?php if( $v['at_image'] && $v['at_show_main_image'] ) echo img( base_url("images/articles/350x260/{$v['at_image']}") );
									else echo img(base_url('images/team/face_1.png'));
								?>
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
							<!-- Memebr Social Links --
							<div class="member-socail">
								<a class="twitter" href="#"><i class="fa fa-twitter"></i></a>
								<a class="gplus" href="#"><i class="fa fa-google-plus"></i></a>
								<a class="linkedin" href="#"><i class="fa fa-linkedin"></i></a>
								<a class="flickr" href="#"><i class="fa fa-flickr"></i></a>
								<a class="mail" href="#"><i class="fa fa-envelope"></i></a>
							</div>
							-->
						</div>
					</div>
					<!-- End Memebr 1 -->
				<?php if( ($k+1)%4==0 ) echo '<br clear="all"><br clear="all">';
				endforeach;?>
				</div>
				<!-- End Team Members -->

			<!-- Divider -->
			<div class="hr1" style="margin-bottom:50px;"></div>
			<!-- Start Clients Carousel -->
			<div class="our-clients">
				<!-- Classic Heading -->
				<h4 class="classic-title"><span>Past Presidents</span></h4>
				<div class="clients-carousel custom-carousel touch-carousel" data-appeared-items="5">

					<?php foreach($pp as $k=>$v):
						$link = "about/pp/{$v['at_id']}/{$v['at_segment']}";
					?>
						<!-- Client 1 -->
						<div class="item thumbnail" style="border:none;">
							<div class="team-member">
								<div class="member-photo">
									<?php if( $v['at_image'] && $v['at_show_main_image'] ) echo img( base_url("images/articles/250x180/{$v['at_image']}") );
										else echo img(base_url('images/team/c1.png'));
									?>
									<div class="member-name">
										<?php echo anchor( $link, $v['at_title'], 'class="wite-text"');?>
									</div>
								</div>
								<div class="caption">
									<?php echo $v['at_summary'];?>
								</div>
							</div>
						</div>
					<?php endforeach;?>
				</div>
			</div>
			<!-- End Clients Carousel -->


		</div>
		</div>
	</div>
	<!-- End content -->
