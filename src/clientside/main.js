var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});


function readCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}


function eraseCookie(name) {
    document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';

	stop();
	$('#admin-page').hide(0);
	$('#personnel-page').hide(0);
	$('#customer-page').hide(0);
	$('#add-user-form').hide(0);
	$('#main-division').show();
	$('#top-menu-customer').show();
	$('#top-menu-admin').hide();
	$('#top-menu-personnel').hide();

	var form = document.getElementById("registration-form");
	form.reset();

	var loginForm = document.getElementById("login-form");
	loginForm.reset();

	clearAssessmentForm();

	$('#log-in-alert').html(
		'<div class="alert alert-success" role="alert"><strong>Success ' +
		 '!</strong> Successfully logged out.</div>');

	$('#footer').hide();
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
										'<td>' + results.entries[i].restaurant_name + '</td>' +
										'<td>' + results.entries[i].minimum_order + '</td>' +
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
						user_row = '<tr>' +
										'<td>' + results.entries[i].fname + ' ' + results.entries[i].mname + ' ' + results.entries[i].lname+ '</td>' +
										'<td>' + results.entries[i].email + '</td>' +
										'<td>' + results.entries[i].tel_number + '</td>' +
										'<td>' + results.entries[i].mobile_number + '</td>' +
										'<td>' + results.entries[i].bldg_number + '</td>' +
										'<td>' + results.entries[i].street + '</td>' +
										'<td>' + results.entries[i].room_number + '</td>' +
										'<td>' + results.entries[i].earned_points + '</td>' +
										'<td>' + results.entries[i].role_id + '</td>' +
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