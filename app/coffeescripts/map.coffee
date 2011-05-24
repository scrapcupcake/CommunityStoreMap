$(document).ready ->
  $('#map').jMapping()
  $("#search").bind "ajax:success", (event, data, status, xhr) -> 
      d = $.parseJSON data
      $("#flash").html d.errors
      $("#map-side-bar").html d.html
      $('#map').jMapping "update"
      $.notifications("#flash")
