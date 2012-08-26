// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function configureReport() {
  setupTimer();
  jQuery.validator.messages.required = "Please select an option";
  $(document).ready(function(){
    $("form").validate({
      highlight: function(element, errorClass, validClass) {
        $(element).parents("p,tr").addClass("errorCell");
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).parents("p,tr").removeClass("errorCell");
      },
      invalidHandler: missedAlert
    });
  });
}

function configureInfo() {
  setupTimer();
  $("a").on("click", function() {
    $("form").first().submit();
  });
}

function setupTimer() {
  timetaken = 0;
  var d = new Date();
  starttime = Math.round(d.getTime() / 1000);
  window.setInterval(updateTime, 1000);
}

function updateTime() {
  var d = new Date();
  var secs = Math.round(d.getTime() / 1000);
  timetaken = secs - starttime;
  $(".timer").val(timetaken);
}

function configureReferral(){
  jQuery.validator.messages.required = "Please select an option:<br />";
  $("form").validate({
    highlight: function(element, errorClass, validClass) {
      $(element).parents("p").addClass("errorCell");
    },
    unhighlight: function(element, errorClass, validClass) {
      $(element).parents("p").removeClass("errorCell");
    },
    errorPlacement: function(error, element){
      error.prependTo(element.parents("p"));
    }
  });
}
