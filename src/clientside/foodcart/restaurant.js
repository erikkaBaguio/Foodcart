var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});


function searchRestaurant(){
	var search = $('#resto-search').val();

	var data = JSON.stringify({ 'search' : search });

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/restaurants/search/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
	    		console.log(results);
				if(results.status == 'OK'){
				$('#search-resto-body').html(function(){
                    var restaurant_row = '';
                            var restaurant;

                            for (var i = 0; i < results.entries.length; i++) {
                                restaurant = '<tr>' +
                                                '<td>' + '<img src="assets/food/images/'+results.entries[i].image_url+'" class="img-responsive" alt="" /></td>' +
                                                '<td>' +'<div class="logo-title"><h4><a href="#" id="view-resto-name"></a></h4>' + results.entries[i].restaurant_name +'</div>'+
														'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">minimum order :'+ results.entries[i].minimum_order +' </p>'+
                                						'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">delivery fee :'+ results.entries[i].delivery_fee +' </p>' + '</td>' +
												'<td>' + '<div class="col-md-2 buy">' +
                                    			'</tr>';

                                restaurant_row  += restaurant
                            }

                            return restaurant_row;
                })
			}
				if(results.status == 'FAILED'){

					$('#resto-search-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#resto-search-alert").fadeTo(2000, 500).slideUp(500);

				}
			},
			error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
			},
			beforeSend: function (xhrObj){

	      		xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

	        }
	    });
}