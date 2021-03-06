/* DO NOT MODIFY. This file was compiled Thu, 02 Jun 2011 03:16:51 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/map.coffee
 */

(function() {
  var resize_map;
  resize_map = function() {
    $('#search').width('auto');
    $('#map').height($(window).height() - 195);
    $('#map').width($(window).width() - $('#search').width() - 85);
    return $('#map').css("left", "0px");
  };
  $(document).ready(function() {
    var mapdata, mc;
    resize_map();
    $(window).resize(resize_map);
    $('#map').jMapping({
      map_config: {
        navigationControlOptions: {
          style: google.maps.NavigationControlStyle.DEFAULT
        },
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoom: 7
      }
    });
    mapdata = $('#map').data('jMapping');
    mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray());
    return $("#new_store_search").bind("ajax:success", function(event, data, status, xhr) {
      var d;
      d = $.parseJSON(data);
      $("#flash").html(d.errors);
      $("#map-side-bar").html(d.map_sidebar);
      $('#map').jMapping("update");
      mapdata = $('#map').data('jMapping');
      mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray());
      return $.notifications("#flash");
    });
  });
}).call(this);
