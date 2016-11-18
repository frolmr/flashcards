function printNumbersInterval() {
  var i = 1;
  func = function go() {
    $("#card_timer").val(i);
    if (i < 61) setTimeout(go, 1000);
    i++;
  }();
}

$(document).ready(function() {
  printNumbersInterval();
});