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


function signup(){
	var fname = $('#fname').val();
	var mname = $('#mname').val();
	var lname = $('#lname').val();
	var user_password = $('#user_password').val();
	var email = $('#user_email').val();
    var tel_number = $('#user_tel_number').val();
	var mobile_number = $('#user_mobile_number').val();
    var bldg_number = $('#user_bldg_number').val();
    var street = $('#user_street').val();
    var room_number = $('#user_room_number').val();
	var role_id = $('#role_id').val();
	var earned_points = $('#earned_points').val();

	var data = JSON.stringify({ 'fname' : fname,
								'mname' : mname,
								'lname' : lname,
								'user_password' : user_password,
								'user_email' : email,
                                'user_tel_number': tel_number,
								'user_mobile_number' : mobile_number,
								'user_bldg_number' : bldg_number,
                                'user_street' : street,
                                'user_room_number' : room_number,
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
	user_form.reset();
}


function login(){
	var email = $('#email_add').val();
	var password = $('#password').val();

	var data = JSON.stringify({'email_add':email, 'password':password});

	$.ajax({

		type:"POST",
		url:"http://localhost:5000/api/foodcart/users/login/",
		contentType:"application/json; charset=utf-8",
		data:data,
		dataType:"json",

		success: function(results){
			console.log(results);
			if(results.status == 'OK'){
				var token = results.token;
				//user_tk is abbrev of user_token
				document.cookie = "user_tk=" + token;
				$('#login-alert').html(
						'<div class="alert alert-success"><strong>Welcome ' +
						results.data[0].fname +
						 '!</strong> Successfully logged in.</div>');

					$("#login-alert").fadeTo(2000, 500).slideUp(500);

					$("#login-form").hide();
				}

			if(results.status == 'FAILED'){
				$('#log-in-alert').html(
					'<div class="alert alert-danger"><strong>FAILED ' +
					 '!</strong> Invalid username or password.</div>');
			}


		},
		error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
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
										'<td>' + results.entries[i].role_id + '</td>' +
										'<td>'+'<button onclick="viewUserById('+ results.entries[i].id +'); $(\'#view-user\').show();$(\'#view-all-user\').hide()" class="btn btn-info">View</button>'+'</td>'+
										// '<td>' + '<button onclick="updateUser('+ results.entries[i].id +'); $(\'#update-user-form\').show(); $(\'#view-all-user\').hide()" class="btn btn-info">Update</button>'+'</td>' +
										// '<td>'+'<button onclick="deactivateUser('+ results.entries[i].id +'); $(\'#view-user\').show()" class="btn btn-danger">Deactivate</button>'+'</td>'+
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