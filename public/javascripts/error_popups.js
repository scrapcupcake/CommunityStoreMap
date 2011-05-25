/* DO NOT MODIFY. This file was compiled Wed, 25 May 2011 04:29:13 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/error_popups.coffee
 */

(function() {
  var alert_type, notify;
  alert_type = function(id) {
    var idtype;
    idtype = id.split('_')[1];
    switch (idtype) {
      case "error":
      case "alert":
        return "error";
      case "warning":
        return "warning";
      default:
        return "";
    }
  };
  notify = function(message) {
    $(message).hide();
    if (message) {
      return $.jnotify($(message).text(), alert_type($(message).attr("id")));
    }
  };
  $.notifications = function(obj) {
    var message, messages, _i, _len, _results;
    messages = $(obj).find('[id*=flash_]');
    _results = [];
    for (_i = 0, _len = messages.length; _i < _len; _i++) {
      message = messages[_i];
      _results.push(notify(message));
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
