notify = (message) ->
  $(message).hide()  
  text = $(message).text()
  idtype = $(message).attr("id").split('_')[1]
  switch idtype
    when "error", "alert" then $.jnotify(text, "error", true)
    when "warning" then $.jnotify(text, "warning")
    else $.jnotify(text)

$.notifications = (obj) ->
  messages = $(obj).find('[id*=flash_]')
  notify message for message in messages

$(document).ready ->
  $.jnotify.setup delay: 3000
  $.notifications("#flash")