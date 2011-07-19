function getSuggestions(query){
  $(".results").empty();
  if(query != ''){
    request = $.getJSON( 'http://localhost:1413/search', { q : query }, function(data) {
      $( "#search_result" ).tmpl( data )
        .appendTo( ".results" );
        inProgress = false;
    });
  }
}

$(document).ready(function() {
  var countdown = null;

  $("input#search_field").focus()
  $("input#search_field").keyup( function(e) {

    e.preventDefault();
    var query = jQuery.trim($(this).val());
    clearTimeout(countdown)
    countdown = setTimeout(function () { getSuggestions(query) }, 500);

  });
});
