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
			$("#total_price_"+index).val(total_price.toFixed(2));
		}else{
			$("#total_price_"+index).val(0);
		}
		$(".total_price").each(function(){
			if($(this).val()){
				total_val = parseFloat(total_val) + parseFloat($(this).val());
			}
		})
		$("#portfolio_balance").val(total_val.toFixed(2));
	});

	$(document).on("change", "#company_change", function(){
		var company_id = $(this).val()
		if(company_id){
			var url = "/sales/fetch_share_quantity";
			$.get(url, {company_id: company_id, format: "js"}, function (data) {
	    });
		}
	});
});