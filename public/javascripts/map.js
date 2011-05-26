/* DO NOT MODIFY. This file was compiled Thu, 26 May 2011 04:11:46 GMT from
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
    window.mapdata = mapdata;
    mc = new MarkerClusterer(mapdata.map, mapdata.gmarkersArray());
    return $("#search").bind("ajax:success", function(event, data, status, xhr) {
      var d;
      d = $.parseJSON(data);
      $("#flash").html(d.errors);
      $("#map-side-bar").html(d.html);
      $('#map').jMapping("update");
      return $.notifications("#flash");
    });
  });
}).call(this);
