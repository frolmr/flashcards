$(document).ready(function() {
  $('#photos').on('click', '.flickr_image', function(){
    $('#card_remote_image_url').val($(this).attr('src'));
    $('.flickr_image').removeClass('selected');
    $(this).toggleClass('selected');
  });
});