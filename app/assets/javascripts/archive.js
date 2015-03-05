$(function() {
  $( "#article-datepicker" ).datepicker({
    dateFormat: "MM-d-yy",
    maxDate: 0,

    onSelect: function(dateText) {
      $('#archive-date-form').attr('action', '/archive/articles/' + dateText);
    }
  });
});
