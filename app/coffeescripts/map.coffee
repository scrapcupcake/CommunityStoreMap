$(document).ready ->
  $('#map').jMapping()
  $("#search").bind "ajax:success", (event, data, status, xhr) -> 
      $("#map-side-bar").html data
      $('#map').jMapping "update"
