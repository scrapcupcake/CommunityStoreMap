alert_type = (id) ->
  idtype = id.split('_')[1]
  switch idtype
    when "error", "alert" then return "error"
    when "warning" then return "warning"
    else return ""
    
notify = (message) ->
  $(message).hide()
  $.jnotify($(message).text(), alert_type($(message).attr("id"))) if message

$.notifications = (obj) ->
  messages = $(obj).find('[id*=flash_]')
  notify message for message in messages

$(document).ready ->
  $.jnotify.setup delay: 3000
  $.notifications("#flash")