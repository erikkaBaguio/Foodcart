/**
 * Created by erikka on 12/12/16.
 */

var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});


function storeRestaurant(){
	var resto_name = $('#resto_name').val();
	var min_order = $('#min_order').val();
	var delivery_fee = $('#delivery_fee').val();
    var image_url = $('#image_url').val();
    var email = $('#email').val();
    var tel_number = $('#tel_number').val();
    var mobile_number = $('#mobile_number').val();
    var bldg_number = $('#bldg_number').val();
    var street = $('#street').val();
    var room_number = $('#room_number').val();

	var data = JSON.stringify({ 'resto_name' : resto_name,
								'min_order' : min_order,
								'delivery_fee' : delivery_fee,
                                'image_url' : image_url,
						        'email' : email,
						        'tel_number' : tel_number,
						        'mobile_number' : mobile_number,
						        'bldg_number' : bldg_number,
						        'street' : street,
						        'room_number' : room_number
							});

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/restaurants/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-resto-alert').html(
						'<br><br><div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-resto-alert").fadeTo(2000, 500).slideUp(500);

					clearRestaurantForm();

				}

				if(results.status == 'FAILED'){

					$('#add-resto-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-resto-alert").fadeTo(2000, 500).slideUp(500);

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


function clearRestaurantForm(){
	var restaurant_form = document.getElementById("restaurant-form");
	restaurant_form.reset();
}


function viewRestaurantById(restaurant_id){
	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/restaurants/" + restaurant_id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{;
			if(results.status == 'OK'){
				$('#view-resto-info').html(function(){
					var restaurant_row = '';
					var restaurant;
					for (var i = 0; i < results.entries.length; i++) {
						restaurant = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Restaurant\'s Name: ' + results. entries[i].restaurant_name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
                                                         'Delivery Fee: ' + results.entries[i].delivery_fee + '<br><br>' +
														 'Minimum Order: ' + results.entries[i].minimum_order + '<br><br>' +
														 'Email: ' + results.entries[i].email + '<br><br>' +
                                                         'Telephone No.: ' + results.entries[i].tel_number + '<br><br>' +
                                                         'Mobile No.: ' + results.entries[i].mobile_number + '<br><br>' +
                                                         'Location: ' + results.entries[i].bldg_number + ' ' +  results.entries[i].street + ' ' + results.entries[i].room_number + '<br><br>' +
                                                         'Image: ' + results.entries[i].image_url + '<br><br>' +
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +
			                        '</div>'

						restaurant_row  += restaurant
					}

					return restaurant_row;
				})

				$('#add-resto-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-resto-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-resto-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function viewAllRestaurant(){

	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/restaurants/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				console.log(results)
				$('#view-resto-table-body').html(function(){
                    var restaurant_row = '';
                            var restaurant;

                            for (var i = 0; i < results.entries.length; i++) {
                                restaurant = '<tr>' +
                                                '<td>' + '<img src="assets/food/images/'+results.entries[i].image_url+'" class="img-responsive" alt="" /></td>' +
                                                '<td>' +'<div class="logo-title"><h4><a href="#" id="view-resto-name"></a></h4>' + results.entries[i].restaurant_name +'</div>'+
														'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">minimum order :'+ results.entries[i].minimum_order +' </p>'+
                                						'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">delivery fee :'+ results.entries[i].delivery_fee +' </p>' + '</td>' +
												'<td>' + '<div class="col-md-2 buy">' +
                                    			'<a class="morebtn hvr-rectangle-in" href="#" style="background-color:#d13517" onclick="deactivateRestaurant(results.entries[i].restaurant_id);">deactivate</a></div>' + '</td>'
                                               '</tr>';

                                restaurant_row  += restaurant
                            }

                            return restaurant_row;
                })

				$('#add-resto-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#message-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#message-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function updateRestaurant(restaurant_branch_id){
	var resto_name = $('#update_resto_name').val();
	var min_order = $('#update_min_order').val();
	var delivery_fee = $('#update_delivery_fee').val();
    var email = $('#update_email').val();
    var tel_number = $('#update_tel_number').val();
    var mobile_number = $('#update_mobile_number').val();
    var bldg_number = $('#update_bldg_number').val();
    var street = $('#update_street').val();
    var room_number = $('#update_room_number').val();

	var data = JSON.stringify({ 'resto_name' : resto_name,
								'min_order' : min_order,
								'delivery_fee' : delivery_fee,
						        'email' : email,
						        'tel_number' : tel_number,
						        'mobile_number' : mobile_number,
						        'bldg_number' : bldg_number,
						        'street' : street,
						        'room_number' : room_number
							});

	$.ajax({
		type:"PUT",
    	url: "http://localhost:5000/api/foodcart/restaurants/" + restaurant_branch_id,
    	contentType:"application/json; charset=utf-8",
		data:data,
		dataType:"json",

		success: function(results){
				if (results.status == 'OK'){

					$('#update-resto-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-resto-alert").fadeTo(2000, 500).slideUp(500);

					clearRestaurantForm();

				}

				if(results.status == 'FAILED'){

					$('#update-resto-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-resto-alert").fadeTo(2000, 500).slideUp(500);

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


function deactivateRestaurant(restaurant_id){
	$.ajax({
		type: "PUT",
		url: "http://localhost:5000/api/foodcart/restaurants/deactivate/" + restaurant_id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results){
				if (results.status == 'OK'){

					$('#deactivate-resto-alert').html(
						'<div class="view-resto-alert"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#deactivate-resto-alert").fadeTo(2000, 500).slideUp(500);

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