<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>
	<!-- Start Services Section -->
	<div class="section service">
		<div class="container">
			<div class="row highlights">
				<div class="col-sm-3">
					<i class="hl-resp"></i>
					<h3><?php echo date('F');?></h3>
					<p><?php if( isset($rotary_theme['mt_name']) ) echo $rotary_theme['mt_name'];?></p>
					<p></p>
				</div>
				
				<div class="col-sm-3">
					<i class="hl-code"></i>
					<h3>Our Meetings</h3>
					<p><?php echo $this->config->item('meetings');?>, <?php echo $this->config->item('address');?></p>
					<p></p>
				</div>
				
				<div class="col-sm-3">
					<i class="hl-customize"></i>
					<h3>
						<?php echo anchor( 'account/register','Become A Member');?>
					</h3>
					<p>
						We are neighbors, community leaders, and global citizens uniting for the common good. With you, we can accomplish even more.
					</p>
					<p></p>
				</div>
				
				<div class="col-sm-3">
					<i class="hl-price"></i>
					<h3>
					<?php 
						if( $this->flexi_auth->is_logged_in() )
							echo anchor( 'account', 'Existing Members');
						else echo anchor( 'account/login', 'Existing Members', 'title="login / register"');
					?>
					</h3>
					<p>
					<?php if( $this->flexi_auth->is_logged_in() ):?>
						Already logged in, <?php echo anchor( 'account/logout', 'logout here' );?>, otherwise 
						<?php echo anchor( 'account', 'view account info' );
						if($this->flexi_auth->is_admin()):?>
							or go to <?php echo anchor( base_url('admin'), 'Admin Panel' );endif;?>.
						<?php else:?>
							Already have an account, <?php echo anchor( 'account/login', 'login here' );?>, otherwise 
							<?php echo anchor( 'account/register', 'create new account' );?>.
						<?php endif;?>
					</p>
					<p></p>
				</div>
			</div>
			<!-- .row highlights-->
		</div>
		<!-- .container -->
	</div>
	<!-- End Services Section -->
