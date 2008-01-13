var highlighter = function () {
  var matched = $(this).attr('class').match(/code_error_line_(\d+)/)
  if(matched.length == 2) {
    $('#code .line_' + matched[1]).toggleClass('error');
  }
}

$(document).ready(function(){
   $("dd.code_error").hover(highlighter, highlighter);
});