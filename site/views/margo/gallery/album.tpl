<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>
					<?php echo $article['at_title']?>
				</h2>
				<p>Gallery</p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li><?php echo anchor( 'gallery', 'Gallery' )?></li>
					<li><?php echo $article['at_title']?></li>
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
		<div class="clear"></div>
		
		<ul id="ul-li" class="thumbnails gallery">
			<?php foreach($images as $k=>$v):?>
				<li data-src="<?php echo base_url('images/articles/main/'.$v['gi_file']);?>" class="col-sm-3">
					<?php echo img( array( 'src'=>"images/articles/250x180/{$v['gi_file']}", 'class'=>'img img-thumbnail' ) );?>
				</li>
			<?php endforeach;?>
		</ul>
	</div>
</div>
<br clear="all"><br clear="all">
