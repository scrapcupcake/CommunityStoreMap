$(document).ready ->
  $('#map').jMapping
      map_config:
        navigationControlOptions:
          style: google.maps.NavigationControlStyle.DEFAULT
        mapTypeId: google.maps.MapTypeId.ROADMAP
        zoom: 7
  mapdata = $('#map').data('jMapping')
  mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray())
  $("#new_store_search").bind "ajax:success", (event, data, status, xhr) -> 
      d = $.parseJSON data
      $("#flash").html d.errors
      $("#map-side-bar").html d.map_sidebar
      $('#map').jMapping "update"
      mapdata = $('#map').data('jMapping')
      mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray())
      $.notifications("#flash")
