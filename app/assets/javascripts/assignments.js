$(document).ready(function(){
	$(document).on("change", "#assignment_assignment_type", function(e){
		var assignment_type = $(this).val();
		if(assignment_type == "Reading"){
			$("#article_ids").show();
		}else{
			$("#article_ids").hide();
		}
	});
})