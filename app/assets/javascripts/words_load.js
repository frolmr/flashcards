$(document).ready(function() {

  function findLength(obj) {
    var count = 0;
    for (var property in obj) {
      count++;
    }
    return count;
  }

  $("#words_load").on("click", function() {
    $.ajax({
      type: 'get',
      url: '/load_word_pairs',
      dataType: 'json',
      data: {
        link: $('#link').val(),
        original_word_tag: $('#original_word_tag').val(),
        translated_word_tag: $('#translated_word_tag').val(),
        deck_id: $('#deck_user_id').val()
      },
      success: function(json) {
        $("#load_result").append("<h4>Создано <strong>" + findLength(json.result) + "</strong> новых карточек</h4>");
        $("#load_result").append("<h4>Ваши новые карточки:</h4><br>");
        for (var property in json.result) {
          $("#load_result").append("<tr><td>" + property + "</td><td>" + json.result[property] + "</td></tr>");
        }
      }
    });
  });
});
