function Timer() {
  var seconds = 1;

  this.startTimer = function () {
    func = function go() {
      $("#card_timer").val(seconds);
      setTimeout(go, 1000);
      seconds++;
    }();
  }

  this.dropTimer = function() {
    seconds = 1;
  }
}

$(document).ready(function() {
  var timer = new Timer();
  timer.startTimer();
  $("#card-check__form").on('submit', function(){
    timer.dropTimer();
  });
});