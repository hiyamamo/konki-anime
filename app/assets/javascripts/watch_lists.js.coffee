# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$(".wl-checkbox").click ->
    toggleCheckBox($(this))

	$(".checkbox-h").click ->
		child = $(".wl-checkbox")
		if $(this).is(":checked")
      child.prop("checked": true)
		else
      child.prop("checked": false)
    toggleCheckBox(child)

toggleCheckBox = (checkbox) ->
  select = checkbox.parent().siblings(".wl-select").children("select")
  if checkbox.is(":checked")
    select.removeAttr("disabled")
  else
    select.attr("disabled", "disabled")


$(document).ready(ready)
$(document).on('page:load', ready)

