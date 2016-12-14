var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});

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



function searchUser(){
	var search = $('#user-search').val();

	var data = JSON.stringify({ 'search' : search });

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/users/search/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#search-user-table-body').html(function(){
					var user_row = '';
					var user;

					for (var i = 0; i < results.entries.length; i++) {
						restaurant = '<tr>' +
										'<td>' + results.entries[i].fname + results.entries[i].mname + results.entries[i].lname+ '</td>' +
										'<td>' + results.entries[i].address + '</td>' +
										'<td>' + results.entries[i].email + '</td>' +
										'<td>' + results.entries[i].mobile_number + '</td>' +
										'<td>' + results.entries[i].role_id + '</td>' +
										'<td>' + results.entries[i].earned_points + '</td>' +
										'</tr>';

						user_row  += user
					}

					return user_row;
				})

				}

				if(results.status == 'FAILED'){

					$('#user-search-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#user-search-alert").fadeTo(2000, 500).slideUp(500);

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


function deactivateUser(id){
	$.ajax({
		type: "PUT",
		url: "http://localhost:5000/api/foodcart/users/deactivate/" + id + "/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results){
				if (results.status == 'OK'){

					$('#update-alert').html(
						'<div class="view-user-alert"><strong>Success ' +
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