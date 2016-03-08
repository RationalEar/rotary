<?php	if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start	Logo & Naviagtion	-->
<div class="navbar navbar-default navbar-top">
	<div class="container">
		<div class="navbar-header">
			<!-- Stat Toggle Nav Link For Mobiles -->
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<i class="fa fa-bars"></i>
			</button>
			<!-- End Toggle Nav Link For Mobiles -->
			<?php echo anchor( base_url(), img('images/logor60.png').'&nbsp;', 'class="navbar-brand" style="padding:8px 0"' );?>
		</div>
		<div class="navbar-collapse collapse">
			<!-- Stat Search -->
			<div class="search-side">
				<a class="show-search"><i class="fa fa-search"></i></a>
				<div class="search-form">
					<?php echo form_open( 'home/search', 'autocomplete="off" role="search" method="get" class="searchform"' );?>
						<input type="text" value="" name="q" id="s" placeholder="Search the site...">
					</form>
				</div>
			</div>
			<!-- End Search -->
			<!-- Start Navigation List -->
			<ul class="nav navbar-nav navbar-right">
				<li>
					<a <?php if($menu=='home') echo 'class="active"';?> href="<?php echo base_url();?>">Home</a>
				</li>
				<li>
					<a <?php if($menu=='about') echo 'class="active"'?> href="<?php echo site_url('about')?>">About Us</a>
				</li>
				<li>
					<a <?php if($menu=='news') echo 'class="active"'?> href="<?php echo site_url('news')?>">News</a>
				</li>
				<li>
					<a <?php if($menu=='projects') echo 'class="active"'?> href="<?php echo site_url('projects')?>">Projects</a>
				</li>
				<li>
					<a <?php if($menu=='reports') echo 'class="active"'?> href="<?php echo site_url('reports')?>">Reports</a>
				</li>
				<li>
					<a <?php if($menu=='gallery') echo 'class="active"'?> href="<?php echo site_url('gallery')?>">Gallery</a>
				</li>
			</ul>
		<!-- End Navigation List -->
		</div>
	</div>

	<!-- Mobile Menu Start -->
	<ul class="wpb-mobile-menu">
		<li>
			<a <?php if($menu=='home') echo 'class="active"';?> href="<?php echo base_url();?>">Home</a>
		</li>
		<li>
			<a <?php if($menu=='about') echo 'class="active"'?> href="<?php echo site_url('about')?>">About Us</a>
		</li>
		<li>
			<a <?php if($menu=='news') echo 'class="active"'?> href="<?php echo site_url('news')?>">News</a>
		</li>
		<li>
			<a <?php if($menu=='projects') echo 'class="active"'?> href="<?php echo site_url('projects')?>">Projects</a>
		</li>
		<li>
			<a <?php if($menu=='reports') echo 'class="active"'?> href="<?php echo site_url('reports')?>">Reports</a>
		</li>
		<li>
			<a <?php if($menu=='gallery') echo 'class="active"'?> href="<?php echo site_url('gallery')?>">Gallery</a>
		</li>
	</ul>
	<!-- Mobile Menu End -->
</div>
<!-- End Header Logo & Naviagtion -->
