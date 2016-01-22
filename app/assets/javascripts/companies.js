$(document).ready(function(){
	$(document).on("keyup", "#purchase_quantity", function(){
		var purchase_quantity = $(this).val();
		var current_price = $("#current_price").val();
		if(purchase_quantity){
			var total_price = purchase_quantity * current_price;
			$("#purchase_total_price").val(total_price.toFixed(2));
		}else{
			$("#purchase_total_price").val(0);
		}
	});
});