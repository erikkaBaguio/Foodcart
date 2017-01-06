var auth_user = "";
var user_role;
var timer = 0;

$(document).ready(function(){

	// decryptCookie();

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
	$('#custommer-page').hide(0);
	$('#logout').hide();
	$('#main-division').show();
	$('#login').show();
	$('#top-right').show();

	var form = document.getElementById("registration-form");
	form.reset();

	var loginForm = document.getElementById("login-form");
	loginForm.reset();

	$('#login-alert').html(
		'<div class="alert alert-success" role="alert"><strong>Success ' +
		 '!</strong> Successfully logged out.</div>');

}


function decryptCookie(){

	var myCookie = readCookie('user_tk');
	var data = JSON.stringify({'token':myCookie});

	$.ajax({

		type:"POST",
	    url:"http://localhost:5000/decrypt",
	    contentType: "application/json; charset=utf-8",
	    data:data,
	    dataType:"json",

	    success: function(results){
	    	auth_user = results.token;
	    	home();
	    },

	    error: function(e, stats, err){
	    	$('#Home').show();
	    	$('#login').show();
	    	$('#top-right').show();
	    }

	});

}


function home(){

	var myCookie = readCookie('user_tk');

	$.ajax({

		type:"GET",
	    url:"http://localhost:5000/api/foodcart/home/" + myCookie,
	    dataType:"json",

	    success: function(results){

	    	$('#login-form').hide();

	    	if(results.status == 'OK'){
				var token = results.token;
				//user_tk is abbrev of user_token
				document.cookie = "user_tk=" + token;

				$('#login').hide(0);
				$('#Home').hide(0);

				if(results.data[0].role == 1){


					user_role = results.data[0].role;

				}

				if(results.data[0].role == 2){

					user_role = results.data[0].role;
					getNotification();
				}

				if(results.data[0].role == 3){

					user_role = results.data[0].role;
				}
			}

			if(results.status == 'FAILED'){
				console.log('FAILED');
			}

	    },

	    error: function(e, stats, err){
	    	console.log(err);
	    	console.log(stats);
			eraseCookie();
	    	$('#login-form').show();
	    },

	    beforeSend: function (xhrObj){

      		xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

        }

	});

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
			
			if(results.status == 'OK'){
	    		// console.log(results);

				var token = results.token;

				//user_tk is abbrev of user_token
				document.cookie = "user_tk=" + token;


				// for system admin
				if(results.data[0].role == 1){

					$('#admin-page').show();

					
					user_role = results.data[0].role;
				}


				// for business personnel
				if(results.data[0].role == 2){


					user_role = results.data[0].role;					
				}


				// for customer
				if(results.data[0].role == 3){

					user_role = results.data[0].role;					
				}

				$('#Home').hide();
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
