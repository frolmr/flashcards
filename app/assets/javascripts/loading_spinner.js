$(document).ready(function() {
  $("#spinner").hide();

  $(document).ajaxStart(function(){
    $("#spinner").show();
  });

  $(document).ajaxStop(function(){
    $("#spinner").hide();
  });
});