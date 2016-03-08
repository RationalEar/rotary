<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
	$this->load->view('default/common/header.tpl');
?>


<!--container-->
<section id="container">
	<div class="breadcrumbs">
	 <div class="container">
		 <h2>Account Login</h2>
		 <p>Rotary Club of Avondale</p>
	 </div>
	</div>
	
	<div class="container">
		<div class="row">
			<section class="col-sm-9">
				<?php echo form_open( current_url(), 'class="form form-horizontal"' );?>
							<div class="form-group">
								<label class="control-label col-sm-3">Username / Email</label>
								<div class="col-sm-7">
									<div class="input-group input-group-lg">
										<span class="input-group-addon"><i class="fa fa-user"></i></span>
										<input type="text" name="login_identity" class="form-control" placeholder="Username / Email">
									</div>
								</div>
							</div>
							<br clear="all">
							<div class="form-group">
								<label class="control-label col-sm-3">Password</label>
								<div class="col-sm-7">
									<div class="input-group input-group-lg">
										<span class="input-group-addon"><i class="fa fa-lock"></i></span>
										<input type="password" name="login_password" class="form-control" placeholder="Password">
									</div>
								</div>
							</div>
							
							<div class="form-group">
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/lost_password')?>" id="lost-password">Lost your password?</a>
								<br>
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/resend_activation_token')?>" 
									id="lost-password">Account not activated?</a>
								<button type="submit" name="login_user" value="1" class="btn btn-primary btn-lg pull-right">Login</button>
								<br>
								<span class="pull-left">No account? 
									<?php echo anchor('account/register', 'Create your account here')?>
								</span>
								
							</div>
						</form>
			</section>
		</div>
	</div>
</section>
	
<?php $this->load->view('default/common/footer.tpl');?>
