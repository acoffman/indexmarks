$(document).ready(function() {
  var inProgress = false;
  var request;
  $("input#search_field").focus()
  $("input#search_field").keyup( function(e) {
    e.preventDefault();

    var query = jQuery.trim($(this).val());
    $(".results").empty();

    if(query != ''){

      if(inProgress){
        request.abort();
      }

      inProgress = true;
      request = $.getJSON( 'http://localhost:1413/search', { q : query }, function(data) {
        $( "#search_result" ).tmpl( data )
          .appendTo( ".results" );
          inProgress = false;
      });
    }
  });
});
