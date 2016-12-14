var auth_user = "";
var user_role;
var timer = 0; 

$(document).ready(function(){


});

function clearFoodForm(){
	var food_form = document.getElementById("food-form");
	food_form.reset();
}

function storeFood(){
	var food_name = $('#food_name').val();
	var description = $('#description').val();
	var unit_cost = $('#unit_cost').val();

	var data = JSON.stringify({ 'food_name' : food_name,
								'description' : description,
								'unit_cost' : unit_cost,
							});

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/foods/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				if (results.status == 'OK'){

					$('#add-food-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-food-alert").fadeTo(2000, 500).slideUp(500);

					$("#add-food-form").hide();

					clearRestaurantForm();

				}

				if(results.status == 'FAILED'){

					$('#add-food-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#add-food-alert").fadeTo(2000, 500).slideUp(500);

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


function viewAllFood(){

	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/foods/",
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-food-table-body').html(function(){
					var food_row = '';
					var food;

					for (var i = 0; i < results.entries.length; i++) {
						food = '<tr>' +
										'<td>' + results.entries[i].food_name + '</td>' +
										// '<td>' + results.entries[i].description + '</td>' +
										// '<td>' + results.entries[i].unit_cost + '</td>' +
										'<td>'+'<button onclick="viewFoodById('+ results.entries[i].food_id +'); $(\'#view-food\').show();$(\'#view-resto\').hide();$(\'#view-all-resto\').hide()" class="btn btn-info">Details</button>'+'</td>'+
										'<td>'+'<button onclick="updateFood('+ results.entries[i].food_id +'); $(\'#update-food-form\').show();$(\'#view-food\').hide();$(\'#view-resto\').hide();$(\'#view-all-resto\').hide()" class="btn btn-info">Update</button>'+'</td>'+
										'<td>'+'<button onclick="deactivateFood('+ results.entries[i].food_id +'); $(\'#update-food-form\').hide();$(\'#view-food\').hide();$(\'#view-resto\').hide();$(\'#view-all-resto\').hide()" class="btn btn-danger">Delete</button>'+'</td>'+
										'</tr>';

						food_row  += food
					}

					return food_row;
				})

				$('#add-food-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-food-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-food-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function viewFoodById(food_id){
	$.ajax({
		type:"GET",
		url: "http://localhost:5000/api/foodcart/foods/" + food_id,
		contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results)
		{
			if(results.status == 'OK'){
				$('#view-food-info').html(function(){
					var food_row = '';
					var food;
					for (var i = 0; i < results.entries.length; i++) {
						food = '<div class="box-body">' +
										'<div class="container">' +
			                                '<div class="row">' +
			                                	'<h4 class="box-title"><b>'+ 'Restaurant\'s Name: ' + results.entries[i].food_name +'</b></h3></div>' +
			                                    '<div class="col-md-4">' +
			                                        '<p style="margin-left: 1px; font-size: 12px">' +
														 'Description: ' + results.entries[i].description + '<br><br>' +
														 'Unit Cost: ' + results.entries[i].unit_cost + '<br><br>' + 
			                                        
			                                        '</p>' +
			                                    '</div>'
			                                '</div>' +
			                            '</div>' +                                       
			                        '</div>'

						food_row  += food
					}

					return food_row;
				})

				$('#add-food-form').hide();
			}

			if(results.status == 'FAILED'){

				$('#view-food-alert').html(
						'<div class="alert alert-danger"><strong>FAILED ' +

						 '!</strong>'+ results.message +' </div>');
				$("#view-food-alert").fadeTo(2000, 500).slideUp(500);

			}
		},

		beforeSend: function (xhrObj){

			xhrObj.setRequestHeader("Authorization", "Basic " + btoa( auth_user ));

		}

	});
}


function updateFood(food_id){
	var food_name = $('#food_name').val();
	var description = $('#description').val();
	var unit_cost = $('#unit_cost').val();

	var data = JSON.stringify({ 'food_name' : food_name,
								'description' : description,
								'unit_cost' : unit_cost,
							});
	$.ajax({
		type:"PUT",
    	url: "http://localhost:5000/api/foodcart/foods/" + food_id,
    	contentType:"application/json; charset=utf-8",
		data:data,
		dataType:"json",

		success: function(results){
				if (results.status == 'OK'){

					$('#update-food-alert').html(
						'<div class="alert alert-success"><strong>Success ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-food-alert").fadeTo(2000, 500).slideUp(500);

					clearFoodForm();

				}

				if(results.status == 'FAILED'){

					$('#update-food-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#update-food-alert").fadeTo(2000, 500).slideUp(500);

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


function deactivateFood(food_id){
	$.ajax({
		type:"PUT",
    	url: "http://localhost:5000/api/foodcart/foods/deactivate/" + food_id,
    	contentType:"application/json; charset=utf-8",
		dataType:"json",

		success: function(results){
			if (results.status == 'OK'){

				$('#view-food-alert').html(
					'<div class="alert alert-success"><strong>Success' +
					 '!</strong>' + results.message +'</div>');

				$("#view-food-alert").fadeTo(2000, 500).slideUp(500);

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

function searchFood(){
	var search = $('#food-search').val();

	var data = JSON.stringify({ 'search' : search });

	$.ajax({
	    	type:"POST",
	    	url: "http://localhost:5000/api/foodcart/foods/search/",
	    	contentType:"application/json; charset=utf-8",
			data:data,
			dataType:"json",

			success: function(results){
				console.log(results);
				if (results.status == 'OK'){

					$('#search-food-table-body').html(function(){
					var food_row = '';
					var food;

					for (var i = 0; i < results.entries.length; i++) {
						food = '<tr>' +
										'<td>' + results.entries[i].food_name + '</td>' +
										'<td>' + results.entries[i].description + '</td>' +
										'<td>' + results.entries[i].unit_cost + '</td>' +
								'</tr>';

						food_row  += food
					}

					return food_row;
				})

				}

				if(results.status == 'FAILED'){

					$('#food-search-alert').html(
						'<div class="alert alert-danger"><strong>Failed ' +
						 '!</strong>' + results.message +'</div>');

					$("#food-search-alert").fadeTo(2000, 500).slideUp(500);

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