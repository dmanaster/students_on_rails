jQuery(document).ready(function($) { 

  $("button#submit").click(function() {
    var search_term = document.getElementById("search_term").value;
    var results =  $("li:contains('" + search_term + "')")
    results.css("background", "yellow");
    results.siblings().slideToggle("slow");
  });



 

})