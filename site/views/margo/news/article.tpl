<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>
					<?php echo $article['at_title'];?>
				</h2>
				<p>News</p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>
						<?php echo anchor( site_url('news'), 'News' );?>
					</li>
					<li><?php echo $article['at_title'];?></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- End Page Banner -->

<!-- Start Content -->
<div class="content">
	<div class="container">
		<div class="row blog-page">
			<br clear="all"><br clear="all">
			<!-- Start Blog Posts -->
			<div class="col-md-9 blog-box">
				<?php
					$link = site_url( "news/i/{$article['at_id']}/{$article['at_segment']}" );
					$img = "images/articles/main/{$article['at_image']}";
					$f = ( file_exists($img) && is_file($img) );
				?>
				<!-- Start Post -->
				<div class="blog-post image-post">
					<!-- Post Thumb -->
					<?php if( $f ):
						$imgt = array( 'src'=>$img, 'class'=>'img' );
					?>
						<div class="post-head">
							<?php echo img($imgt);?>
						</div>
					<?php endif;?>
					<!-- Post Content -->
					<div class="post-content">
						<h2>
							<?php echo anchor( $link, $article['at_title'] );?>
						</h2>
						<ul class="post-meta">
							<?php if($article['at_show_author']):?>
								<li>By <a href="#"><?php echo "{$article['first_name']} {$article['last_name']}";?></a></li>
							<?php endif;?>
							<li><?php echo date( 'M jS, Y', $article['at_date_posted'] ).' at '.date('g:i a', $article['at_date_posted']);?></li>
							<li><a href="#">0 Comments</a></li>
						</ul>
						<div>
							<?php echo html_entity_decode($article['at_text']);?>
						</div>
						
						<br clear="all"><br clear="all">
						<ul class="pager">
							<?php if( isset( $previous_article['at_id'] ) ):?>
								<li class="previous">
									<?php echo anchor( "news/i/{$previous_article['at_id']}/{$previous_article['at_segment']}", 
										'&larr; '.character_limiter($previous_article['at_title'], 30), 'title="'.$previous_article['at_title'].'"' );?>
								</li>
							<?php endif;?>
							<?php if( isset( $next_article['at_id'] ) ):?>
								<li class="next">
									<?php echo anchor( "news/i/{$next_article['at_id']}/{$next_article['at_segment']}", 
										character_limiter($next_article['at_title'], 30).' &rarr;', 'title="'.$next_article['at_title'].'"' );?>
								</li>
							<?php endif;?>
						</ul>
					</div>
					<!-- post content -->
				</div>
				<!-- End Post -->
			</div>
			<!-- col-sm-9 blog-box -->
			
			<!--Sidebar-->
			<div class="col-md-3 sidebar right-sidebar">

				<!-- Search Widget -->
				<div class="widget widget-search">
					<?php echo form_open( 'home/search', 'method="GET"' );?>
						<input type="search" name="q" placeholder="Enter Keywords..." />
						<button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
					</form>
				</div>

				<!-- Popular Posts widget -->
				<div class="widget widget-popular-posts">
					<h4>
						Recent Posts <span class="head-line"></span>
					</h4>
					<ul>
						<?php foreach( $recent_articles as $k=>$v ):
							$link = site_url( "news/i/{$v['at_id']}/{$v['at_segment']}" );
							$img = "images/articles/100x75/{$v['at_image']}";
							$f = ( file_exists($img) && is_file($img) );
						?>
							<li>
								<?php if( $v['at_show_main_image'] && $f ):
									$imgt = array( 'src'=>$img, 'class'=>'img' );
									$cl = 30;
								?>
									<div class="widget-thumb">
										<?php echo anchor( $link, img($imgt), array('title'=>$v['at_title']) );?>
									</div>
								<?php else: $cl = 40;endif;?>
								<div class="widget-content">
									<h5>
										<?php echo anchor( $link, character_limiter($v['at_title'],$cl), array('title'=>$v['at_title']) );?>
									</h5>
									<span><?php echo date( 'M d Y', $v['at_date_posted'] );?></span>
								</div>
								<div class="clearfix"></div>
							</li>
						<?php endforeach;?>
					</ul>
				</div>

				<!-- Tags Widget -->
				<div class="widget widget-tags">
					<h4>Tags <span class="head-line"></span></h4>
					<div class="tagcloud">
						<?php foreach( $tags as $v ) echo anchor( site_url('home/search')."?q=$v", $v ).' ';?>
					</div>
				</div>

			</div>
			<!--End sidebar-->
			
		</div>
	</div>
</div>
