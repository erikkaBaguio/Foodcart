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
	var restaurant_form_2 = document.getElementById("restaurant-form-2");
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