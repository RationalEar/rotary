<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<div class="col-sm-12">
	<h2 class="welcome">
		<span class="text-info">Edit <?php echo $title?></span>
	</h2>
</div>


<div class="col-sm-12">
	<ul class="breadcrumb">
		<li>
			<?php echo anchor( 'home', '<i class="radmin-icon radmin-home"></i>Dashboard' );?>
			<span class="divider">/</span>
		</li>
		<li>
			<?php echo anchor( 'articles', '<i class="radmin-icon radmin-clipboard-2"></i>Articles' );?>
			<span class="divider">/</span>
		</li>
		<li class="active">
			<i class="radmin-icon radmin-file-word"></i> <?php echo $title;?>
		</li>
	</ul>
</div> <!-- end of span12 -->

<div class="squiggly-border col-sm-12"></div>


<?php echo form_open( current_url(), 'class="form form-horizontal" name="blog_post"' );?>

	<div class="col-sm-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">About Us (Summary)</h3>
			</div>
			<div class="panel-body">
				
				<div class="form-group">
					<label class="control-label col-sm-3">Title</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="title" value="<?php echo $about['at_title'];?>" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12">
						<label class="control-label">Summary <small>(max 300 characters)</small></label>
						<textarea class="form-control" rows="3" name="summary" max-length="300"
							placeholder="leave blank for automatic generation"><?php echo $about['at_summary'];?></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3">Upload Image</label>
					<div class="col-sm-9">
						<span id="upload" class="uneditable-input col-sm-9 form-control">
							no file chosen... <small>(recommended 900x623px)</small>
						<span>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-9 col-offset-sm-3">
						<div id="status"></div>
						<ul id="upload_files" class="thumbnails unstyled">
							<?php $image = $about['at_image']?$about['at_image']:$this->input->post('image');
							if($image):?>
							<li id="<?php echo $image;?>">
								<div class="thumbnail">
									<?php $href = base_url("images/articles/main/{$image}");
									$src = base_url("images/articles/250x180/{$image}");?>
									<a target="_blank" class="fancybox" rel="gp" 
									href="<?php echo $href;?>"><?php echo img($src);?></a>
									<p>
										<button class="btn btn-xs btn-default product_img_fs" type="button" 
											value="<?php echo $image;?>" onclick="delete_piffs(this)">delete</button>
										<input type="hidden" name="image" id="image_name" value="<?php echo $image?>">
									</p>
								</div>
							</li>
							<?php endif;?>
						</ul>
					</div>
				</div>
				
			</div>
		</div>
	</div>

	<div class="col-sm-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Article Settings</h3>
			</div>
			<div class="panel-body">
				
				<div class="form-group">
					<label class="control-label col-sm-3">URL Segment</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="segment" value="<?php echo $about['at_segment'];?>" 
							placeholder="leave blank to use title">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Section</label>
					<div class="col-sm-8">
						<select class="form-control" name="section" readonly>
							<?php foreach($sections as $k=>$v):
								$s = ($v['sc_id']==$about['sc_id'])?'selected':'';
							?>
								<option value="<?php echo $v['sc_id']?>" <?php echo $s;?>><?php echo $v['sc_name'];?></option>
							<?php endforeach;?>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="permalink">Permanent Link:</label>
					<div class="col-sm-9">
						<input type="hidden" name="permalink" value="0">
						<label class="checkbox">
							<?php $s = $about['at_permalink']?'checked':'';?>
							<input id="permalink" type="checkbox" name="permalink" value="1" <?php echo $s;?>> Yes
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="show_image">Main Image:</label>
					<div class="col-sm-9">
						<input type="hidden" name="show_image" value="0">
						<label class="checkbox">
							<?php $s = $about['at_show_main_image']?'checked':'';?>
							<input id="show_image" type="checkbox" name="show_image" value="1" <?php echo $s;?>> Show in Article
						</label>
					</div>
				</div>
				<input type="hidden" name="show_author" value="">
				<input type="hidden" name="enabled" value="<?php echo $about['at_enabled'];?>">
				<input type="hidden" name="featured" value="0">
				
				<div class="form-group">
					<label class="control-label col-sm-3">Submit</label>
					<div class="col-sm-9" style="text-align:right;">
						<?php echo anchor( 'about/club', 'Cancel', 'class="btn btn-default"' );?>
						<button type="submit" name="submit" value="1" class="btn btn-primary">Submit</button>
						<input type="hidden" name="form_name" value="article">
						<input type="hidden" name="form_type" value="update">
						<input type="hidden" name="id" value="<?php echo $about['at_id'];?>">
						<input type="hidden" name="action_string" value="<?php echo  base_url('article_thumb.php');?>" 
							id="action_string">
						<input type="hidden" name="script" value="article_thumb.php" id="action_file">
					</div>
				</div>
				
			</div>
		</div>
	</div>

	<div class="col-sm-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Article Body</h3>
			</div>
			<div class="panel-body">
				<div class="control-group">
					<div class="controls">
						<textarea class="ckeditor1 col-sm-12" id="ckeditor1" rows="15" 
							placeholder="Start typing here..." name="text"><?php 
							echo html_entity_decode($about['at_text']);?></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>

</form>
