$.notifications = (obj) ->
  $(obj).hide()
  error = $(obj).find('#flash_error').text()
  warning = $(obj).find('#flash_warning').text()
  notice = $(obj).find('#flash_notice').text()
  $.jnotify(error, "error") if error
  $.jnotify(warning, "warning") if warning
  $.jnotify(notice) if notice
  

$(document).ready ->
  $.jnotify.setup delay: 3000
  $.notifications("#flash")