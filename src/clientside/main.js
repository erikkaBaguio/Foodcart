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
	// $('#customer-page').hide(0);
	$('#add-user-form').hide(0);
	$('#main-division').show();
	$('#top-menu-customer').show();
	$('#top-menu-admin').hide();
	$('#top-menu-personnel').hide();
	$('#order').show();
	$('#top-right').show();
	$('#customer-menu').show();
	$('#admin-menu').hide();
	$('#personnel-menu').hide();
	$('#logout').hide();


	var form = document.getElementById("register");
	form.reset();

	var loginForm = document.getElementById("login");
	loginForm.reset();

	$('#login-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						results.data[0].fname +
						 '!</strong> Successfully logged out.</div>');

					$("#login-alert").fadeTo(2000, 500).slideUp(500);

}


function decryptCookie(){

	var myCookie = readCookie('user_tk');
	var data = JSON.stringify({'token':myCookie});

    $('#main-division').show();

	$.ajax({

		type:"POST",
	    url:"http://localhost:5000/decrypt",
	    contentType: "application/json; charset=utf-8",
	    data:data,
	    dataType:"json",

	    success: function(results){
	    	auth_user = results.token;
	    	home();
	    	$('#login-loading-image').hide();

	    },

	    error: function(e, stats, err){
	    	$('#login').show();
	    	$('#main-division').show();
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
	    	$('#footer').show();
	    	$('#landing-page-header').hide();

	    	if(results.status == 'OK'){
				var token = results.token;
				//user_tk is abbrev of user_token
				document.cookie = "user_tk=" + token;

				$('#log-in-page').hide(0);

				if(results.data[0].role == 1){
					$('#admin-page').show(0);

					user_role = results.data[0].role;

				}

				if(results.data[0].role == 2){
					$('#doctor-page').show(0);
					$('#doctor-name').html(results.data[0].fname + ' ' + results.data[0].lname);
					user_role = results.data[0].role;
					getNotification();
				}

				if(results.data[0].role == 3){
					$('#nurse-page').show();
					user_role = results.data[0].role;
					$('#nurse-name').html(results.data[0].fname + ' ' + results.data[0].lname);
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
	    	$('#footer').hide();
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
				if(results.status == 'OK'){
				$('#search-resto-table-body').html(function(){
                    var restaurant_row = '';
                            var restaurant;

                            for (var i = 0; i < results.entries.length; i++) {
                                restaurant = '<tr>' +
                                                '<td>' + '<img src="assets/food/images/'+results.entries[i].image_id + '" class="img-responsive" alt="" /></td>' +
                                                '<td>' +'<div class="logo-title"><h4><a href="#" id="view-resto-name"></a></h4>' + results.entries[i].restaurant_name +'</div>'+
														'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">minimum order :'+ results.entries[i].minimum_order +' </p>'+
                                						'<p style="line-height:1; font-size:1em; color:#6b6969; font-weight:400">delivery fee :'+ results.entries[i].delivery_fee +' </p>' + '</td>' +
												'<td>' + '<div class="col-md-2 buy">' +
												'<a class="morebtn hvr-rectangle-in" onclick="viewAllFood(' + results.entries[i].restaurant_id + ');">order</a></div>' + '</td>'

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