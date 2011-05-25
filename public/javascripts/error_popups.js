/* DO NOT MODIFY. This file was compiled Tue, 24 May 2011 05:04:43 GMT from
 * /home/archangelq/Projects/HandCannonCommunity/app/coffeescripts/error_popups.coffee
 */

(function() {
  $.notifications = function(obj) {
    var error, notice, warning;
    $(obj).hide();
    error = $(obj).find('#flash_error').text();
    warning = $(obj).find('#flash_warning').text();
    notice = $(obj).find('#flash_notice').text();
    if (error) {
      $.jnotify(error, "error");
    }
    if (warning) {
      $.jnotify(warning, "warning");
    }
    if (notice) {
      return $.jnotify(notice);
    }
  };
  $(document).ready(function() {
    $.jnotify.setup({
      delay: 3000
    });
    return $.notifications("#flash");
  });
}).call(this);
