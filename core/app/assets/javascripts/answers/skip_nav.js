$(document).ready(function(){
	$("#skip_nav a").click(function(){
		$("#main_content_container").attr('tabIndex', -1).focus();
	});
	$("#main_content_container").blur(function(){
		$("#main_content_container").removeAttr('tabIndex');
	});
});