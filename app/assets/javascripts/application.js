// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require fancybox
//= require_tree .

$('.logo').transition({
	perspective: '100px',
	rotateY: '180deg'
});

$.fn.serializeJSON = function() {
	var values = this.serializeArray(),
		json = {};

	values.forEach(function(elem) {
		if(json[elem.name])
		{
			if(Array.isArray(json[elem.name])) json[elem.name].push(elem.value);
			else json[elem.name] = [json[elem.name], elem.value];
		}
		else json[elem.name] = elem.value;
	});
}

$('.plan-btn').on('click', function() {
	var $this = $(this);
	$.ajax(
		$this.attr('action'),
		{
			accepts: 'json',
			dataType: 'json',
			contentType: "application/json",
			processData: false,
			type: 'PATCH',
			data: JSON.stringify({
				plan: $this.val()
			})
		}
	);
	$('.plan-btn').attr('disabled', false);
	$this.attr('disabled', true);

	return false;
});
$('#plan_change').find('form').each(function() {
	$(this).attr('action', $(this).attr('action')+'.json')
})
