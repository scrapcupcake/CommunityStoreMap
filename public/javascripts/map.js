/* DO NOT MODIFY. This file was compiled Fri, 20 May 2011 04:29:02 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/map.coffee
 */

(function() {
  $(document).ready(function() {
    $('#map').jMapping();
    return $("#search").bind("ajax:success", function(event, data, status, xhr) {
      $("#map-side-bar").html(data);
      return $('#map').jMapping("update");
    });
  });
}).call(this);
