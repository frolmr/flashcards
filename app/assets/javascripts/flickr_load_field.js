$(document).ready(function() {
  $('#flickr_load_form').hide();
  $('#flickr_load_form_toggle').on('click', function(e) {
    e.preventDefault();
    $('#flickr_load_form').show();
  });
});