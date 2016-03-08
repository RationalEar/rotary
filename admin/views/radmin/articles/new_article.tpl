<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');?>

<div class="col-sm-12">
	<h2 class="welcome">
		<span class="text-info">New Article</span>
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
			<i class="radmin-icon radmin-file-word"></i> New Article
		</li>
	</ul>
</div> <!-- end of span12 -->

<div class="squiggly-border col-sm-12"></div>


<?php echo form_open( current_url(), 'class="form form-horizontal" name="blog_post"' );?>

	<div class="col-sm-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">Article Summary</h3>
			</div>
			<div class="panel-body">
				
				<div class="form-group">
					<label class="control-label col-sm-3">Title</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="title" value="<?php echo $this->input->post('title')?>" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-12">
						<label class="control-label">Summary <small>(max 300 characters)</small></label>
						<textarea class="form-control" rows="3" name="summary" max-length="300"
							placeholder="leave blank for automatic generation"><?php echo $this->input->post('summary');?></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3">URL Segment</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" name="segment" value="<?php echo $this->input->post('title')?>" 
							placeholder="leave blank to use title">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">Section</label>
					<div class="col-sm-8">
						<select class="form-control" name="section">
							<?php foreach($sections as $k=>$v):?>
								<option value="<?php echo $v['sc_id']?>"><?php echo $v['sc_name']?></option>
							<?php endforeach;?>
						</select>
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
							<?php $image = $this->input->post('image')?$this->input->post('image'):$this->input->post('image');
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
					<label class="control-label col-sm-3" for="show_author">Author:</label>
					<div class="col-sm-9">
						<input type="hidden" name="show_author" value="0">
						<label class="checkbox">
							<input id="show_author" type="checkbox" name="show_author" value="1"> Show Author
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="permalink">Permanent Link:</label>
					<div class="col-sm-9">
						<input type="hidden" name="permalink" value="0">
						<label class="checkbox">
							<input id="permalink" type="checkbox" name="permalink" value="1"> Yes
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="show_image">Main Image:</label>
					<div class="col-sm-9">
						<input type="hidden" name="show_image" value="0">
						<label class="checkbox">
							<input id="show_image" type="checkbox" name="show_image" value="1"> Show in Article
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="enabled">Status:</label>
					<div class="col-sm-9">
						<input type="hidden" name="enabled" value="0">
						<label class="checkbox">
							<input id="enabled" type="checkbox" name="enabled" value="1"> Published
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="private">Private:</label>
					<div class="col-sm-9">
						<input type="hidden" name="private" value="0">
						<label class="checkbox">
							<input id="private" type="checkbox" name="private" value="1"> Yes
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3" for="featured">Featured:</label>
					<div class="col-sm-9">
						<input type="hidden" name="featured" value="0">
						<label class="checkbox">
							<input id="featured" type="checkbox" name="featured" value="1"> Yes
						</label>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-3">Date Published</label>
					<?php $tom = date( 'Y-m-d H:i' );?>
					<div class="col-sm-7">
						<div class="input-group date" id="datetimepicker1" data-time="<?php echo $tom;?>" data-format="DD-MM-YYYY, HH:mm">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
							<input type='text' class="form-control" name="date_posted" value="<?php echo $this->input->post('date_posted')?>" 
								placeholder="leave blank to use current time">
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-3">Submit</label>
					<div class="col-sm-9" style="text-align:right;">
						<?php echo anchor( 'articles', 'Cancel', 'class="btn btn-default"' );?>
						<button type="submit" name="submit" value="1" class="btn btn-primary">Submit</button>
						<input type="hidden" name="form_name" value="article">
						<input type="hidden" name="form_type" value="insert">
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
							echo html_entity_decode($this->input->post('text'));?></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>

</form>
