// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function configureReport() {
  timetaken = 0;
  var d = new Date();
  starttime = Math.round(d.getTime() / 1000);
  window.setInterval(updateTime, 1000);
  $("a").on("click", function() {
    $("form").first().submit();
  });
}

function updateTime() {
  var d = new Date();
  var secs = Math.round(d.getTime() / 1000);
  timetaken = secs - starttime;
  $(".timer").val(timetaken);
}
