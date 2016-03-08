<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>Create Account</h2>
				<p><?php echo $this->config->item('site-name');?></p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li><a href="<?php echo site_url('account');?>">Account</a></li>
					<li>Register</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<br clear="all"><br clear="all">

<!-- Start Content -->
<div class="content">
	<div class="container">
		<div class="row blog-page">
			<br clear="all"><br clear="all">
			<!-- Start Blog Posts -->
			<div class="col-md-9 blog-box">
				<?php echo form_open( current_url(), 'class="form form-horizontal"' );?>
					<div class="form-group">
						<label class="control-label col-sm-3">First Name</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
									<input type="text" name="register_first_name" class="form-control" 
								placeholder="First Name" value="<?php echo $this->input->post('register_first_name');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Surname</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input type="text" name="register_last_name" class="form-control" placeholder="Surname" 
									value="<?php echo $this->input->post('register_last_name');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Phone Number</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-phone"></i></span>
								<input type="text" name="register_phone_number" class="form-control" 
									placeholder="Phone Number"	
									value="<?php echo $this->input->post('register_phone_number');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Email Address</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
								<input type="email" name="register_email_address"class="form-control" 
									placeholder="Email Address" 
									value="<?php echo $this->input->post('register_email_address');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Username</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input type="text" name="register_username" class="form-control" placeholder="Username" 
									value="<?php echo $this->input->post('register_username');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Password</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-key"></i></span>
								<input type="password" name="register_password" class="form-control" 
								placeholder="Password" value="<?php echo $this->input->post('register_password');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3">Confirm Password</label>
						<div class="col-sm-7">
							<div class="input-group input-group-md">
								<span class="input-group-addon"><i class="fa fa-key"></i></span>
								<input type="password" name="register_confirm_password" class="form-control" 
									placeholder="Confirm Password" 
									value="<?php echo $this->input->post('register_confirm_password');?>">
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<span class="pull-left">Already have an account? 
							<?php echo anchor( 'account/login', 'Login here' )?>
						</span>
						<button type="submit" name="register_user" value="1" 
							class="btn btn-primary btn-lg pull-right">Register</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
