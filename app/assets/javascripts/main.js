$(document).ready(function(){
	$('#add').click(function() {
		$('#tableWrapper').append('<tr><td>Friend</td><td><input type="text" value="" name="friends[]" /></td></tr>');

	});
});
