resize_map = ->
  $('#search').width('auto')
  if $('#search').width() < $(window).width() - 500
    $('#container').css('margin-top', 50 )
    $('#map').height( $(window).height() - 60 )
    $('#map').width( $(window).width() - $('#search').width() - 10 )
    $('#map').css('top', 50 )  
  else
    $('#map').height( $(window).height() - 100 )
    $('#map').width( $(window).width() - 25 )
    $('#search').width( $(window).width() - 25 )
    $('#map').css('top', $("#search").height() + $("#user_nav").height() + 80 )
    $('#container').css('margin-top', $("#user_nav").height() + 50 )


$(document).ready ->
  resize_map()
  $(window).resize(resize_map)
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
