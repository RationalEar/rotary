<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
<!-- Start Page Banner -->
<div class="page-banner page-section-banner">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2>Resend Activation Token</h2>
				<p><?php echo $this->config->item('site-name');?></p>
			</div>
			<div class="col-md-6">
				<ul class="breadcrumbs">
					<li><a href="<?php echo base_url();?>">Home</a></li>
					<li><a href="<?php echo site_url('account');?>">Account</a></li>
					<li>Login</li>
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
		<div class="row blog-page">
			<br clear="all"><br clear="all">
			<!-- Start Blog Posts -->
			<div class="col-md-9 blog-box">
				<?php echo form_open( current_url(), 'class="form form-horizontal"' );?>
							<div class="form-group">
								<label class="control-label col-sm-3">Username / Email</label>
								<div class="col-sm-7">
									<div class="input-group input-group-lg">
										<span class="input-group-addon"><i class="fa fa-user"></i></span>
										<input type="text" name="activation_token_identity" class="form-control" 
										placeholder="email address or username.">
									</div>
									<span>Please enter either your email address or username defined during registration.</span>
								</div>
							</div>
							
							<div class="form-group">
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/login')?>" id="lost-password">Login Here</a>
								<br>
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/lost_password')?>" id="lost-password">Lost your password?</a>
								
								<button type="submit" name="send_activation_token" value="1" class="btn btn-primary btn-lg pull-right">Submit</button>
								<br>
								<span class="pull-left">No account? 
									<?php echo anchor('account/register', 'Create your account here')?>
								</span>
								
							</div>
						</form>
			</div>
		</div>
	</div>
</div>
<br clear="all"><br clear="all">
