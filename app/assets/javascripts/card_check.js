$(document).ready(function() {
  $("#card-check__form").on("ajax:complete", function() {
    $.ajax({
      type: 'get',
      url: '/',
      dataType: 'json',
      success: function(json) {
        $("#card__image").html($("<img>", { src: json.image }));
        $("#card__text").text(json.translated_text);
        $("#card_id").val(json.id);
        $("#card_original_text").val("");
        $("#flash").html("<div class='alert alert-" + json.flash[0][0] + "'>" + json.flash[0][1] + "</div>");
      }
    });
  });
});