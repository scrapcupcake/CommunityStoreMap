$(document).ready ->
  $('#map').jMapping
      map_config:
        navigationControlOptions:
          style: google.maps.NavigationControlStyle.DEFAULT
        mapTypeId: google.maps.MapTypeId.ROADMAP
        zoom: 7
  mapdata = $('#map').data('jMapping')
  window.mapdata = mapdata
  mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray())
  $("#search").bind "ajax:success", (event, data, status, xhr) -> 
      d = $.parseJSON data
      $("#flash").html d.errors
      $("#map-side-bar").html d.html
      $('#map').jMapping "update"
      $.notifications("#flash")
