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
										'<td>' + results.entries[i].restaurant_name + '</td>' +
										// '<td>' + results.entries[i].minimum_order + '</td>' +
										// '<td>' + results.entries[i].delivery_fee + '</td>' +
										// '<td>' + results.entries[i].location + '</td>' +
										'<td>'+'<button onclick="viewRestaurantById('+ results.entries[i].restaurant_id +'); $(\'#view-resto\').show();$(\'#view-all-resto\').hide()" class="btn btn-info">View</button>'+'</td>'+
										'<td>'+'<button onclick="updateRestaurant('+ results.entries[i].restaurant_id +'); $(\'#update-resto-form\').show();$(\'#view-all-resto\').hide()" class="btn btn-info">Update</button>'+'</td>'+
										'<td>'+'<button onclick="deactivateRestaurant('+ results.entries[i].restaurant_id +'); $(\'#update-resto-form\').hide();" class="btn btn-danger">Deactivate</button>'+'</td>'+
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

function updateRestaurant(restaurant_id){
	var resto_name = $('#update_resto_name').val();
	var min_order = $('#update_min_order').val();
	var delivery_fee = $('#update_delivery_fee').val();
	var location = $('#update_location').val();
	var restaurant_id = restaurant_id;

	var data = JSON.stringify({ 'restaurant_id': restaurant_id,
									'resto_name' : resto_name,
									'min_order' : min_order,
									'delivery_fee' : delivery_fee,
									'location' : location	
								});
	
	$.ajax({
		type:"PUT",
    	url: "http://localhost:5000/api/foodcart/restaurants/" + restaurant_id,
    	contentType:"application/json; charset=utf-8",
		data:data,
		dataType:"json",

		success: function(results){
				if (results.status == 'OK'){

					$('#update-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-alert").fadeTo(2000, 500).slideUp(500);

					clearRestaurantForm();

				}

				if(results.status == 'FAILED'){

					$('#update-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-alert").fadeTo(2000, 500).slideUp(500);

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

					$('#update-alert').html(
						'<div class="view-resto-alert"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-alert").fadeTo(2000, 500).slideUp(500);

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
				if (results.status == 'OK'){

					$('#search-resto-table-body').html(function(){
					var restaurant_row = '';
					var restaurant;

					for (var i = 0; i < results.entries.length; i++) {
						restaurant = '<tr>' +
										'<td>' + results.entries[i].restaurant_name + results.entries[i].restaurant_id+ '</td>' +
										'<td>' + results.entries[i].minimum_order + '</td>' +
										'<td>' + results.entries[i].delivery_fee + '</td>' +
										'<td>' + results.entries[i].location + '</td>' +
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