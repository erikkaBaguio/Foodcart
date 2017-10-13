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

				if(results.data[0].role == 1){
					localStorage.setItem('fname', res.userinfo[0].fname);
                	localStorage.setItem('lname', res.userinfo[0].lname);
                	localStorage.setItem('user_id', res.userinfo[0].user_id);
				}

				if(results.data[0].role == 2){
				}

				if(results.data[0].role == 3){
				}

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
			}


		},
		error: function(e){
				alert("THIS IS NOT COOL. SOMETHING WENT WRONG: " + e);
		}

	});

}
