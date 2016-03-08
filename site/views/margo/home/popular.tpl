<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Testimonials Section -->
<div>
	<div class="container">
		<div class="row">
			<div class="col-md-8">

			<!-- Start Recent Posts Carousel -->
			<div class="latest-posts">
				<h4 class="classic-title"><span>Latest News</span></h4>
				<div class="latest-posts-classic custom-carousel touch-carousel" data-appeared-items="2">

					<?php foreach( $recent_articles as $k=>$v ):
						$link = site_url( "news/i/{$v['at_id']}/{$v['at_segment']}" );
					?>
						<!-- Posts 1 -->
						<div class="post-row item">
							<div class="left-meta-post">
								<div class="post-date">
									<span class="day"><?php echo date('d',$v['at_date_posted']);?></span>
									<span class="month"><?php echo date('M',$v['at_date_posted']);?></span>
								</div>
								<div class="post-type"><i class="fa fa-picture-o"></i></div>
							</div>
							<h3 class="post-title">
								<?php echo anchor( $link, character_limiter($v['at_title'],30), array('title'=>$v['at_title']) );?>
							</h3>
							<div class="post-content">
								<p>
									<?php echo character_limiter($v['at_summary'],100);?> 
									<?php echo anchor( $link, 'Read More... ', 'class="read-more"' );?>
								</p>
							</div>
						</div>
					<?php endforeach;?>
				</div>
			</div>
			<!-- End Recent Posts Carousel -->
		</div>

		<div class="col-md-4">

			<!-- Classic Heading -->
			<h4 class="classic-title"><span>Popular Posts</span></h4>

			<!-- Start Testimonials Carousel -->
			<div class="custom-carousel show-one-slide touch-carousel" data-appeared-items="1">
				<?php foreach( $popular_articles as $k=>$v ):?>
					<!-- Testimonial 1 -->
					<div class="classic-testimonials item">
						<div class="testimonial-content">
							<p>
								<?php echo character_limiter($v['at_summary'],160);?> 
							</p>
						</div>
						<div class="testimonial-author">
							<span>
								<?php echo anchor( $link, character_limiter($v['at_title'],30), array('title'=>$v['at_title']) );?>
							</span> - <?php echo date( 'M d Y', $v['at_date_posted'] );?>
						</div>
					</div>
				<?php endforeach;?>
			</div>
			<!-- End Testimonials Carousel -->
		</div>
	</div>
</div>
<!-- End Testimonials Section -->
