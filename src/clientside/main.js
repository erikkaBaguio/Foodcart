var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){


});


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

			if(results.status == 'OK'){
				var token = results.token;
				//user_tk is abbrev of user_token
				document.cookie = "user_tk=" + token;


				// for system admin
				if(results.data[0].role == 1){
					$('#top-menu-admin').show();
					$('#top-menu-personnel').hide(0);
					$('#top-menu-customer').hide(0);
					$('#order').hide();
					$('#Home').hide();
					$('#search-resto-table-body').hide();
					$('#search-resto-table').hide();
					$('#admin-page').show();
					$('#admin-menu').show();

				}


				// for business personnel
				if(results.data[0].role == 2){
					$('#top-menu-admin').hide(0);
					$('#top-menu-personnel').show();
					$('#personnel-page').show();
					$('#personnel-menu').show();
					$('#top-menu-customer').hide(0);
					$('#order').hide();
					$('#Home').hide();
				}


				// for customer
				if(results.data[0].role == 3){
					$('#top-menu-admin').hide(0);
					$('#top-menu-personnel').hide(0);
					$('#top-menu-customer').show();
					$('#Home').hide();
				}

				$('#login').hide();
				$('#top-right').hide();
				$('#logout').show();

				$('#login-alert').html(
						'<div class="alert alert-success"><strong>Welcome ' +
						results.data[0].fname +
						 '!</strong> Successfully logged in.</div>');

					$("#login-alert").fadeTo(2000, 500).slideUp(500);
				}

			if(results.status == 'FAILED'){
				$('#login-alert').html(
					'<div class="alert alert-danger"><strong>FAILED ' +
					 '!</strong> Invalid username or password.</div>');

				$("#login-alert").fadeTo(2000, 500).slideUp(500);
			}


		},
		error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
		}

	});
}
