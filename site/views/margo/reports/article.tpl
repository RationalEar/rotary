<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>
					<?php echo $article['at_title'];?>
				</h2>
				<p>Reports</p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>
						<?php echo anchor( site_url('reports'), 'Reports' );?>
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
					$link = site_url( "reports/i/{$article['at_id']}/{$article['at_segment']}" );
					$img = "images/articles/main/{$article['at_image']}";
					$f = ( file_exists($img) && is_file($img) );
				?>
				<!-- Start Post -->
				<div class="blog-post image-post">
					<!-- Post Thumb -->
					<?php if( $article['at_show_main_image'] && $f ):
						$imgt = array( 'src'=>$img, 'class'=>'img' );
					?>
						<div class="post-head">
							<?php echo anchor( $link, img($imgt), array('title'=>$article['at_title']) );?>
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
					</div>
				</div>
				<!-- End Post -->
			</div>
		</div>
	</div>
</div>
