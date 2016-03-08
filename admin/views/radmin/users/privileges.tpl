<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<div class="col-sm-12">
	<h2 class="welcome">
		<span class="text-info">User Privileges</span>
		<?php echo anchor( 'users/new_privilege', 'New User Privilege', 'class="btn btn-primary btn-sm pull-right"' );?>
	</h2>
</div>


<div class="col-sm-12">
	<ul class="breadcrumb">
		<li>
			<?php echo anchor( 'home', '<i class="radmin-icon radmin-home"></i>Dashboard' );?>
			<span class="divider"></span>
		</li>
		<li>
			<?php echo anchor( 'users', '<i class="radmin-icon radmin-user-3"></i>Users' );?>
			<span class="divider"></span>
		</li>
		<li class="active">
			<i class="radmin-icon radmin-user"></i> User Privileges
		</li>
	</ul>
</div> <!-- end of span12 -->

<div class="squiggly-border col-sm-12"></div>

<div class="col-sm-12">
	<table class="table table-condensed table-dotted">
		<tr>
			<th>#</th>
			<th>Name</th>
			<th>Description</th>
			<th>Options</th>
		</tr>
		<?php foreach($privileges as $k=>$v):?>
		<tr>
			<td><?php echo $v['upriv_id'];?></td>
			<td><?php echo $v['upriv_name'];?></td>
			<td><?php echo $v['upriv_desc'];?></td>
			<td><?php 
				echo anchor( current_url().'?action=edit_privilege&id='.$v['upriv_id'], 
					'<span class="radmin radmin-pencil"></span>', 'class="btn btn-primary btn-xs" title="edit privilege info"' ).'&nbsp;';
				echo anchor( current_url().'?action=delete_privilege&id='.$v['upriv_id'], 
					'<span class="radmin radmin-remove"></span>', 'class="btn btn-danger btn-xs" title="delete privilege"' );
			?>
			</td>
		</tr>
		<?php endforeach;?>
	</table>
</div>
