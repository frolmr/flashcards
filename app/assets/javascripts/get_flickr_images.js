$(document).ready(function() {
  $('#search_images').on("click", function(e) {
    data = $('#flickr_tag').val();
    $.ajax({
      url: '/find_flickr_images',
      type: 'put',
      dataType: 'json',
      data: { flickr_tag: data },
      success: function(json) {
        images = json.list;
        images.forEach(function(item, i , images) {
          $('<img />', {'src': item, 'class': "flickr_image"}).appendTo('#photos');
        });
      }
    });
  });
});
