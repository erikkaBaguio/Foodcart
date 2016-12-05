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
	restaurant_form_2.reset();
}


function signup(){
	var fname = $('#fname').val();
	var mname = $('#mname').val();
	var lname = $('#lname').val();
	var address = $('#address').val();
	var email = $('#email').val();
	var mobile_number = $('#mobile_number').val();
	var user_password = $('#user_password').val();
	var role_id = $('#role_id').val();
	var earned_points = $('#earned_points').val();

	var data = JSON.stringify({ 'fname' : fname,
								'mname' : mname,
								'lname' : lname,
								'address' : address,
								'email' : email,
								'mobile_number' : mobile_number,
								'user_password' : user_password,
								'role_id' : role_id,
								'earned_points' : earned_points
							});

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/users/signup/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-user-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-user-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-user-form").hide();

					clearSignupForm();

				}

				if(results.status == 'FAILED'){

					$('#add-user-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-user-alert").fadeTo(2000, 500).slideUp(500);

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


function clearSignupForm(){
	var user_form = document.getElementById("user-form");
	var user_form_2 = document.getElementById("user-form-2");
	user_form.reset();
	user_form_2.reset();
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


function viewAllUser(){

	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/users/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-user-table-body').html(function(){
					var user_row = '';
					var user;

					for (var i = 0; i < results.entries.length; i++) {
						user = '<tr>' +
										'<td>' + results.entries[i].fname + ' ' + results.entries[i].lname + '</td>' +
										'<td>'+'<button onclick="viewUserById('+ results.entries[i].id +'); $(\'#view-user\').show();$(\'#view-all-user\').hide()" class="btn btn-info">View</button>'+'</td>'+
										'<td>' + '<button onclick="updateUser('+ results.entries[i].id +'); $(\'#update-user-form\').show(); $(\'#view-all-user\').hide()" class="btn btn-info">Update</button>'+'</td>'
									 '</tr>';

						user_row  = user_row + user
					}

					return user_row;
				})

				$('#add-user-form').hide();
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


function viewUserById(id){
	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/users/" + id + "/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			console.log(results.entries);
			if(results.status == 'OK'){
				$('#view-user-info').html(function(){
					var user_row = '';
					var user;
					for (var i = 0; i < results.entries.length; i++) {
						user = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Name: ' + results.entries[i].fname + ' ' + results.entries[i].mname + '. ' + results.entries[i].lname +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 5px">' +
														 'Address: ' + results.entries[i].address + '<br><br>' +
														 'Mobile Number: ' + results.entries[i].mobile_number + '<br><br>' +
														 'Role ID: ' + results.entries[i].role_id + '<br><br>' +
								  						 'Points: ' + results.entries[i].earned_points + '<br><br>' +
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +
			                        '</div>'

						user_row  += user
					}

					return user_row;
				})

				$('#add-user-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-user-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-user-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function updateUser(id){
	var fname = $('#fname').val();
	var mname = $('#mname').val();
	var lname = $('#lname').val();
	var address = $('#address').val();
	var email = $('#email').val();
	var mobile_number = $('#mobile_number').val();
	var user_password = $('#user_password').val();
	var role_id = $('#role_id').val();
	var earned_points = $('#earned_points').val();
	var id = id;

	var data = JSON.stringify({ 'id' : id,
								'fname' : fname,
								'mname' : mname,
								'lname' : lname,
								'address' : address,
								'email' : email,
								'mobile_number' : mobile_number,
								'user_password' : user_password,
								'role_id' : role_id,
								'earned_points' : earned_points
							});

 	$.ajax({
 		type:"PUT",
     	url: "http://localhost:5000/api/foodcart/users/update/",
     	contentType:"application/json; charset=utf-8",
 		data:data,
 		dataType:"json",

 		success: function(results){
 				if (results.status == 'OK'){

 					$('#update-user-alert').html(
 						'<div class="alert alert-success"><strong>Success ' +
 						 '!</strong>' + results.message +'</div>');

 					$("#update-user-alert").fadeTo(2000, 500).slideUp(500);

 					clearSignupForm();

 				}

 				if(results.status == 'FAILED'){

 					$('#update-user-alert').html(
 						'<div class="alert alert-danger"><strong>Failed ' +
 						 '!</strong>' + results.message +'</div>');

 					$("#update-user-alert").fadeTo(2000, 500).slideUp(500);

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