<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<div class="col-sm-12">
	<h2 class="welcome">
		<span class="text-info">About The Club</span>
	</h2>
</div>


<div class="col-sm-12">
	<ul class="breadcrumb">
		<li>
			<?php echo anchor( 'home', '<i class="radmin-icon radmin-home"></i>Dashboard' );?>
			<span class="divider">/</span>
		</li>
		<li>
			<?php echo anchor( 'about', '<i class="radmin-icon radmin-home"></i>About' );?>
			<span class="divider">/</span>
		</li>
		<li class="active">
			<i class="radmin-icon radmin-user"></i> About The Club
		</li>
	</ul>
</div> <!-- end of span12 -->

<div class="squiggly-border col-sm-12"></div>

<div class="col-sm-12">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">About Us</h3>
		</div>
		<div class="panel-body">
			<?php if( isset($about['at_id']) ):?>
				<div style="text-align:right;">
					<?php echo anchor( 'about/club/edit', 'Edit About Us', 'class="btn btn-primary"' ).'&nbsp;&nbsp;';
						echo anchor( home_url($about['at_segment']), 'View About Us', 'class="btn btn-primary" target="_blank"' );
					?>
				</div>
				<br clear="all"><br clear="all">
				
				<div>				
					<?php echo html_entity_decode( $about['at_text'] );?>
				</div>
			
			<?php else:?>
				<?php echo anchor( 'about/club/new', 'Add About Us', 'class="btn btn-primary pull-right"' );?>
			<?php endif;?>
		</div>
	</div>
</div>
