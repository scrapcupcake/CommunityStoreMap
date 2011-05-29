/* DO NOT MODIFY. This file was compiled Sun, 29 May 2011 21:42:06 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/map.coffee
 */

(function() {
  $(document).ready(function() {
    var mapdata, mc;
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
