<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
	$this->load->view('default/common/header.tpl');
?>


<!--container-->
<section id="container">
	<div class="breadcrumbs">
	 <div class="container">
		 <h2>Manual Reset Forgotten Password</h2>
		 <p>Rotary Club of Avondale</p>
	 </div>
	</div>
	
	<div class="container">
		<div class="row">
			<section class="col-sm-9">
				<?php echo form_open( current_url(), 'class="form form-horizontal"' );?>
							
				<div class="form-group">
					<label class="control-label col-sm-4" for="new_password">New Password <span class="required">*</span></label>
					<div class="col-sm-6">
						<input type="password" id="new_password" name="new_password" value="" 
						class="form-control input-sm" required>
					</div>
				</div>
			
				<div class="form-group">
					<label class="control-label col-sm-4" for="confirm_new_password">Confirm New Password <span>*</span></label>
					<div class="col-sm-6">
						<input type="password" id="confirm_new_password" name="confirm_new_password" value="" 
						class="form-control input-sm" required>
					</div>
				</div>
							
							<div class="form-group">
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/login')?>" id="lost-password">Login Here</a>
								<br>
								<a class="btn-link pull-left" 
									href="<?php echo site_url('account/lost_password')?>" id="lost-password">Lost your password?</a>
								
								<button type="submit" name="change_forgotten_password" value="1" class="btn btn-primary btn-lg pull-right">Submit</button>
								<br>
								<span class="pull-left">No account? 
									<?php echo anchor('account/register', 'Create your account here')?>
								</span>
								
							</div>
							
							
							<div class="form-group">
					<div class="col-sm-11 col-sm-offset-1">
						<small>
							Note: Password length must be more than <?php echo $this->flexi_auth->min_password_length(); ?> 
							characters in length.<br/>
							Only alpha-numeric, dashes, underscores, periods and comma characters are allowed.
						</small>
					</div>
				</div>
							
						</form>
			</section>
		</div>
	</div>
</section>
	
<?php $this->load->view('default/common/footer.tpl');?>
