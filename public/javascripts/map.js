/* DO NOT MODIFY. This file was compiled Tue, 24 May 2011 05:02:33 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/map.coffee
 */

(function() {
  $(document).ready(function() {
    $('#map').jMapping();
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
