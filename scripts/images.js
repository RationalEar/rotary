$(function(){
	
	var action_string = $('#action_string').val();
	var base_url = $('#base_url').val();
	var btnUpload=$('#upload');
		var status=$('#status');
		new AjaxUpload(btnUpload, {
			action: action_string,
			name: 'uploadfile',
			onSubmit: function(file, ext){
				 if (! (ext && /^(jpg|png|jpeg|gif)$/.test(ext))){ 
                    // extension is not allowed 
					status.text('Only JPG, PNG or GIF files are allowed');
					return false;
				}
				status.text('Uploading...Please wait until upload is finished');
			},
			onComplete: function(file, response)
			{
				//On completion clear the status
				status.text('');
				//Add uploaded file to list
				if(response['error_msg']==="success")
				{
					
					if(response['form']==="profile")
					{
						$('#photo').val(response['photo']);
						var phot = document.getElementById("profile_picture");
						phot.innerHTML = '<span><img src="'+base_url+'images/users/250px/'+response['photo']+'"></span>';
						
						if( response['auto'] )
							$('#change_profile_pic').submit();
					}
					
					else if(response['form']==="blog_article")
					{
						im = document.blog_post.image;
						if(im) delete_img(im.value);
						//$('#image_name').val(response['image']);
						curl = $('#current_url').val();
						burl = $('#base_url').val();
						li = '<li id="'+response['image']+'"><div class="thumbnail"><img src="'+burl+'images/articles/250x180/'+response['image']+'"></div><p><button class="btn btn-sm btn-mini btn-default product_img_fs" type="button" value="'+response['image']+'" onclick="delete_piffs(this)">delete</button></p> <input type="hidden" name="image" value="'+response['image']+'"> </li>';
						$('#upload_files').prepend(li);
						//document.getElementById('image_name').value = response['image'];
					}
					
					else if(response['form']==="products")
					{
						$('#images').val(response['image']);
						curl = $('#current_url').val();
						burl = $('#base_url').val();
						//id = $('#listing_id').val();
						li = '<li><a href="'+burl+'images/products/'+response['image']+'"><img src="'+burl+'images/products/210x120/'+response['image']+'"><div class="image_options"><a href="'+curl+'?action=images&file='+response['image']+'&trig=del"> delete </a><a href="'+curl+'?action=images&file='+response['image']+'&trig=make_main"> make main </a></div></a></li>';
						$('#upload_files').prepend(li);
						
						op = '<option value="'+response['image']+'" selected>image</option>';
						$('#image_names').prepend(op);
						//update_list_images(id,response['image'],burl,curl);
					}
					
					else if(response['form']==="companies")
					{
						$('#main_image').val(response['image']);
						curl = $('#current_url').val();
						burl = $('#base_url').val();
						li = '<li><a href="'+burl+'images/company_profiles/'+response['image']+'"><img src="'+burl+'images/company_profiles/210x120/'+response['image']+'"></a></li>';
						$('#upload_files').html(li);
					}
					
					else if(response['form']==="articles")
					{
						$('#main_image').val(response['image']);
						curl = $('#current_url').val();
						burl = $('#base_url').val();
						li = '<li><a href="'+burl+'images/articles/'+response['image']+'"><img src="'+burl+'images/articles/250x180/'+response['image']+'"></a></li>';
						$('#upload_files').html(li);
					}
					
					else if(response['form']==="page_banner")
					{
						$('#main_image').val(response['image']);
						curl = $('#current_url').val();
						burl = $('#base_url').val();
						li = '<li><a href="'+burl+'images/page_banners/'+response['image']+'"><img src="'+burl+'images/page_banners/210x120/'+response['image']+'"></a></li>';
						$('#upload_files').html(li);
					}
				}
				else
				{
					//alert( response['error'] );
					$('<p></p>').prependTo('#status').text(response['error']).addClass('alert alert-warning alert-error');
				}
			}
		});
		
	
	function update_list_images(id, image, burl, curl){
		var x = 'id='+id+'&image='+image;
		
		if(id>0){
		$.ajax({
			type: "GET",
			url: burl+"/admin/ajax/update_list_image",
			data: x,
			dataType: 'json',
			success: function(re){
				if(re['error']){
					$('.success').text(re['error_msg']);
				}
			}
		});}
		else{
			alert('unknown error');
		}
	}



});


function delete_piffs( obj ){
		var btn = $(obj);
		var img = btn.val();
		btn.text( 'deleting...' );
		var base_url = $('#base_url').val();
		if( img )
		{
			var x = 'file='+img+'&fs=1';
			$.ajax(
			{
				type: "GET",
				url: base_url+"admin/ajax/delete_article_image",
				data: x,
				dataType: 'json',
				timeout: 60000,
				success: function(re)
				{
					if(re['error'])
					{
						btn.text( 'image deleted' );
						$('#image_name').val('');
						remove_item( document.getElementById(img) );
					}
					else
					{
						btn.text( 'could not delete image' );
					}
				},
				error: function(a,b,re)
				{
					if( b=='timeout' )
						btn.text('The request timed out');
					else
					{
						btn.text('an error occurred');
					}
					 
					//setTimeout( 'remove_by_id("'+aid+'")', 5000 );
				}
			});
		}
	}

	function remove_item(i)
	{
		j=i.parentNode;
		j.removeChild(i);
	}
	


	function delete_img( img )
	{
		var base_url = $('#base_url').val();
		if( img )
		{
			var btn = $( '#'+img+' button' );
			btn.text( 'deleting...' );
			var x = 'file='+img+'&fs=1';
			$.ajax(
			{
				type: "GET",
				url: base_url+"admin/ajax/delete_article_image",
				data: x,
				dataType: 'json',
				timeout: 60000,
				success: function(re)
				{
					if(re['error'])
					{
						btn.text( 'image deleted' );
						$('#image_name').val('');
						remove_item( document.getElementById(img) );
					}
					else
					{
						btn.text( 'could not delete image' );
					}
				},
				error: function(a,b,re)
				{
					if( b=='timeout' )
						btn.text('The request timed out');
					else
					{
						btn.text('an error occurred');
					}
					 
					//setTimeout( 'remove_by_id("'+aid+'")', 5000 );
				}
			});
		}
		else $('<p></p>').prependTo('#status').text(img+' not found').addClass('alert alert-warning alert-error');
	}
