// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.validate
//= require_tree .

function missedAlert(form, validator) {
  var errors = validator.numberOfInvalids();
  if (errors) {
    $("input:blank").first().focus();
    var message = errors == 1
      ? 'You missed 1 question. It has been highlighted.'
      : 'You missed ' + errors + ' questions. They have been highlighted.<br/>';
    $("#dialog-confirm").html(message);
    $("#dialog-confirm").dialog("open");
    // Make sure dialog in centred after scrolling up to focus on first missed question.
    setTimeout("$('#dialog-confirm').dialog('widget').position({my: 'center', at: 'center', of: window});", 20);
  }
}

function configureCheck() {
  jQuery.validator.messages.required = ""

  $(function() {
    $("#dialog-confirm").dialog({
      autoOpen: false,
      resizable: false,
      width: 500,
      modal: true,
      buttons: {
        "Go back to missed questions": function() {
          $( this ).dialog( "close" );
        }
      }
    });
  });

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
