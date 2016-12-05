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