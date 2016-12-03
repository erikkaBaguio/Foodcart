var auth_user = "";
var user_role;
var timer = 0; 

$(document).ready(function(){


});


function storeRestaurant(){
	var resto_name = $('#resto_name').val();
	var min_order = $('#min_order').val();
	var delivery_fee = $('#delivery_fee').val();
	var location = $('#location').val();

	var data = JSON.stringify({ 'resto_name' : resto_name,
								'min_order' : min_order,
								'delivery_fee' : delivery_fee,
								'location' : location	
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
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-resto-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-resto-form").hide();

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


function viewAllRestaurant(){

	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/restaurants/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-resto-table-body').html(function(){
					var restaurant_row = '';
					var restaurant;

					for (var i = 0; i < results.entries.length; i++) {
						restaurant = '<tr>' +
										'<td>' + results.entries[i].restaurant_name + results.entries[i].restaurant_id+ '</td>' +
										// '<td>' + results.entries[i].minimum_order + '</td>' +
										// '<td>' + results.entries[i].delivery_fee + '</td>' +
										// '<td>' + results.entries[i].location + '</td>' +
										'<td>'+'<button onclick="viewRestaurantById('+ results.entries[i].restaurant_id +'); $(\'#view-resto\').show();$(\'#view-all-resto\').hide()" class="btn btn-info">View</button>'+'</td>'+
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


function viewRestaurantById(restaurant_id){
	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/restaurants/" + restaurant_id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			console.log(results.entries);
			if(results.status == 'OK'){
				$('#view-resto-info').html(function(){
					var restaurant_row = '';
					var restaurant;
					'Minimum Order' + results.entries.minimum_order 
					for (var i = 0; i < results.entries.length; i++) {
						restaurant = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Restaurant\'s Name: ' + results.entries[i].restaurant_name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
														 'Minimum Order: ' + results.entries[i].minimum_order + '<br><br>' +
														 'Delivery Fee: ' + results.entries[i].delivery_fee + '<br><br>' + 
														 'Location: ' + results.entries[i].location + '<br><br>' +
			                                        
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