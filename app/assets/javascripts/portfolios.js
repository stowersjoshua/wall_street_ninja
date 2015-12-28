$(document).ready(function(){
	$(document).on("change", ".select_company", function(){
		var company_id = $(this).val()
		var index = $(this).attr("data-attr");
		if(company_id){
			var url = "/portfolios/"+ company_id +"/fetch_current_price";
			$.get(url, {index: index, format: "js"}, function (data) {
	    });
		}
	});

	$(document).on("keyup", ".enter_quantity", function(){
		var quantity = $(this).val();
		var index = $(this).attr("data-attr");
		var price = $("#price_"+index).val();
		var total_val = 0;
		var total_price = quantity * price;
		if(quantity){
			$("#total_price_"+index).val(total_price);
		}else{
			$("#total_price_"+index).val(0);
		}
		$(".total_price").each(function(){
			if($(this).val()){
				alert("price");
				total_val = parseInt(total_val) + parseInt($(this).val());
			}
		})
		$("#portfolio_balance").val(total_val);
	});
});