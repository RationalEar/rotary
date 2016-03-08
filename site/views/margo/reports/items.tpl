<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>Reports</h2>
				<p><?php echo $this->config->item('site-name');?></p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>Reports</li>
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
				<?php foreach($articles as $k=>$v):
					$link = site_url( "reports/i/{$v['at_id']}/{$v['at_segment']}" );
					$img = "images/articles/main/{$v['at_image']}";
					$f = ( file_exists($img) && is_file($img) );
				?>
				<!-- Start Post -->
				<div class="blog-post image-post">
					<!-- Post Thumb -->
					<?php if( $v['at_show_main_image'] && $f ):
						$imgt = array( 'src'=>$img, 'class'=>'img' );
					?>
						<div class="post-head">
							<?php echo anchor( $link, img($imgt), array('title'=>$v['at_title']) );?>
						</div>
					<?php endif;?>
					<!-- Post Content -->
					<div class="post-content">
						<h2>
							<?php echo anchor( $link, $v['at_title'] );?>
						</h2>
						<ul class="post-meta">
							<?php if($v['at_show_author']):?>
								<li>By <a href="#"><?php echo "{$v['first_name']} {$v['last_name']}";?></a></li>
							<?php endif;?>
							<li><?php echo date( 'M jS, Y', $v['at_date_posted'] ).' at '.date('g:i a', $v['at_date_posted']);?></li>
							<li><a href="#">0 Comments</a></li>
						</ul>
						<p>
							<?php echo $v['at_summary'];?>
						</p>
						<?php echo anchor( $link, 'Read More <i class="fa fa-angle-right"></i>', 'class="main-button"' )?>
					</div>
				</div>
				<!-- End Post -->
				<?php endforeach;?>
			</div>
			
			
			<!-- Start Pagination -->
			<div class="col-xs-12">
				<ul class="pagination pull-left">
					<li class="disabled"><a style="border:none;">
					Showing <?php echo $start?> to <?php echo $current_rows?> of <?php echo $total_rows?> items
					</a></li>
				</ul>
				<ul class="pagination pull-right">
					<?php echo $this->pagination->create_links(); ?>
				</ul>
			</div>
			<!-- End Pagination -->
			
		</div>
	</div>
</div>
