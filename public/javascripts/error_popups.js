/* DO NOT MODIFY. This file was compiled Thu, 26 May 2011 01:56:33 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/error_popups.coffee
 */

(function() {
  var notify;
  notify = function(message) {
    var idtype, text;
    $(message).hide();
    text = $(message).text();
    idtype = $(message).attr("id").split('_')[1];
    switch (idtype) {
      case "error":
      case "alert":
        return $.jnotify(text, "error", true);
      case "warning":
        return $.jnotify(text, "warning");
      default:
        return $.jnotify(text);
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
