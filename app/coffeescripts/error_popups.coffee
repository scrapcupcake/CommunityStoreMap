alert_type = (id) ->
  idtype = id.split('_')[1]
  switch idtype
    when "error" then return "error"
    when "warning", "alert" then return "warning"
    else return ""

$.notifications = (obj) ->
  $(obj).hide()
  messages = $(obj).find('[id*=flash_]')
  ($.jnotify($(message).text(), alert_type($(message).attr("id"))) if message) for message in messages

$(document).ready ->
  $.jnotify.setup delay: 3000
  $.notifications("#flash")