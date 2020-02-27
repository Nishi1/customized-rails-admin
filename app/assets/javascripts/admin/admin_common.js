$(document).ready(function(){	
	$(document).on('click','.parent-checkbox',function(){
    if ($(this).is(':checked')) {   
      $('.child-checkbox').prop('checked', true);
    } else {
      $('.child-checkbox').prop('checked', false);
    }
  });

	$(document).on('click','.child-checkbox',function(){
		if ($('.child-checkbox:checked').length == $('.child-checkbox').length ){
			$(".parent-checkbox").prop('checked', true);
		} else {
			$(".parent-checkbox").prop('checked', false);
		}
	});	

  $(document).on('click','.delete-admin-info',function(){
     $('#model_id').val($(this).attr('data-attr'));
     $('#model_name').val($(this).attr('data-attr-model'));
     $('#modal-default-delete').modal('show'); 
  })
  
  $(document).on('click','button.delete_confirmed',function(){    
    if($('#bulk_perform_action').val() == "true") {
      $('#listing_form')[0].submit();
    } else {
     var model_id = $('#model_id').val();
     var model_name = $('#model_name').val();     
     if(model_id != '' && model_name != '') {
         delete_record(model_id, model_name);         
     }
   }
  }) 
  


  $(document).on('submit','#listing_form',function(e){
    e.preventDefault();
    var submit_form = true; 
    if($('.child-checkbox:checked').length == 0) {
      submit_form = false;
      $('.bulk_action_error').html("Please select any record").show();
    } else if($('#bulk_action').val() == "") {
      submit_form = false;
      $('.bulk_action_error').html("Please select atleast one action").show();
    } 

    if(submit_form){    
      if( $('#bulk_action').val() == 'delete') {
          $('#bulk_perform_action').val(true);
          $('#modal-default-delete').modal('show');
      } else {
        $('#listing_form')[0].submit(); 
      }
    } 
  })


})

function delete_record(model_id, model_name){   

    params = get_url_params();
  
    if (typeof(params['page']) != "undefined" && params['page'] > 0) {
     
       if($('.child-checkbox').length == 1 && params['page'] > 1) {          
          page_number = (params['page'] - 1)
       } else {
          page_number = params['page'];
       }
       if(typeof(params['search'])  != "undefined" && params['search'] != "") {
       	  url_params = "?page="+page_number+"&search="+params['search']; 
       } else {
       	  url_params = "?page="+page_number;
       } 
      
     } else {
       if(typeof(params['search']) != "undefined" && params['search'] != "") {
       	  url_params = "?search="+params['search'];
       } else {
       	  url_params = "";
       } 
    }

    url = BASE_URL+window.location.pathname+url_params
    $.ajax({
      type: 'post',
      url: BASE_URL + "/admin/delete_record",
      data: {"model_id": model_id, "model_name": model_name,  authenticity_token: $('[name="csrf-token"]')[0].content},
      dataType: 'json',
      success: function (response) {
        if (response.status) {
          
        } else {
          
        }  
        window.location.href = url;     
      }              
  })

}

function get_url_params(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++){
        hash = hashes[i].split('=');        
        vars[hash[0]] = hash[1];
    }
    return vars;
}



