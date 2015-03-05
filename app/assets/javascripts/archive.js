$(function() {
  var baseUrl = $('#archive-date-form').data('root-url');
  $( "#datepicker" ).datepicker({
    dateFormat: "MM-d-yy",
    maxDate: 0,

    onSelect: function(dateText) {
      $('#archive-date-form').attr('action', baseUrl + dateText);
    }
  });
});
