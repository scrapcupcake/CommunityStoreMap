/* DO NOT MODIFY. This file was compiled Wed, 25 May 2011 04:22:04 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/error_popups.coffee
 */

(function() {
  var alert_type;
  alert_type = function(id) {
    var idtype;
    idtype = id.split('_')[1];
    switch (idtype) {
      case "error":
        return "error";
      case "warning":
      case "alert":
        return "warning";
      default:
        return "";
    }
  };
  $.notifications = function(obj) {
    var message, messages, _i, _len, _results;
    $(obj).hide();
    messages = $(obj).find('[id*=flash_]');
    _results = [];
    for (_i = 0, _len = messages.length; _i < _len; _i++) {
      message = messages[_i];
      _results.push((message ? $.jnotify($(message).text(), alert_type($(message).attr("id"))) : void 0));
    }
    return _results;
  };
  $(document).ready(function() {
    $.jnotify.setup({
      delay: 3000
    });
    return $.notifications("#flash");
  });
}).call(this);
