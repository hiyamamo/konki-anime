# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$(".wl-checkbox").click ->
		select = $(this).parent().siblings(".wl-select").children("select")
		if $(this).is(":checked")
			select.removeAttr("disabled")
			select.css("background", "white")
		else
			select.css("background", "gray")
			select.attr("disabled", "disabled")

$(document).ready(ready)
$(document).on('page:load', ready)

