// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function showHideSpinner(show) {
	document.getElementById('LoadingSpinner').style.visibility = (show) ? "visible" : "hidden";
    if (show) { document.body.style.cursor = 'progress'; } else { document.body.style.cursor = 'default';} 
}

function showFixedOptions() {
	$('alloted_hours').show();
	$('alloted_hours_overrun').show();
	$('alloted_hours_notify_pm').show();
}

function showFlexOptions() {
	$('alloted_hours').hide();
	$('alloted_hours_overrun').hide();
	$('alloted_hours_notify_pm').hide();
}