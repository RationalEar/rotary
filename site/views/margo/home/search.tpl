<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
$this->load->view("$theme/common/header.tpl");?>

<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>Search</h2>
				<p>
					Your search for <strong><i><?php echo $search_term?></i></strong> returned <strong><?php echo $total_rows;?></strong> 
					result<?php if($total_rows!=1) echo 's';?>
					<br clear="all">
					Currently showing <?php echo $start?> to <?php echo $current_rows?> of <?php echo $total_rows?> items
				</p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li>Search</li>
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
					$sc = $v['sc_value'];
					$scn = count(explode( '/', $sc ));
					if( $scn > 1 ) $link = site_url( "$sc/{$v['at_id']}/{$v['at_segment']}" );
					else $link = site_url( "$sc/i/{$v['at_id']}/{$v['at_segment']}" );
				?>
				<!-- Start Post -->
				<div class="blog-post standard-post">
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
			
			<!--Sidebar-->
			<div class="col-md-3 sidebar right-sidebar">

				<!-- Search Widget -->
				<div class="widget widget-search">
					<?php echo form_open( 'home/search', 'method="GET"' );?>
						<input type="search" name="q" placeholder="Enter Keywords..." value="<?php if(isset($search_term)) echo $search_term;?>"/>
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
										<?php echo anchor( $link, character_limiter($v['at_title'],$cl) );?>
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

<?php $this->load->view("$theme/common/footer.tpl");?>
