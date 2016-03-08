<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>Gallery</h2>
				<p><?php echo $this->config->item('site-name');?></p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>Gallery</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- End Page Banner -->

<!-- Start Content -->
<div class="content">
	<div class="container">
		<div class=" portfolio-page portfolio-3column">
			<br clear="all"><br clear="all">
			<!-- Start Blog Posts -->
			<ul id="portfolio-list" data-animated="fadeIn">
				<?php foreach($articles as $k=>$v):
					$link = site_url("gallery/i/{$v['at_id']}/{$v['at_segment']}");
				?>
				<li>
					<?php echo img( base_url("images/articles/350x260/{$v['at_image']}") );?>
					<div class="portfolio-item-content">
						<span class="header"><?php echo anchor( $link, $v['at_title'], 'class="wite-text"' );?></span>
						<p class="body"><?php echo $v['at_summary'];?></p>
					</div>
					<?php echo anchor( $link, '<i class="more">+</i>' );?>
				</li>
			<?php endforeach;?>
			</ul>
			
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
