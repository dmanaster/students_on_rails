jQuery(document).ready(function($) { 

  $("button#submit").click(function() {
    var search_term = new RegExp(document.getElementById("search_term").value, "i");
    
    var results =  $("li:contains(search_term)")
    alert(results);
    results.css("background", "yellow");
    results.siblings().slideToggle("slow");
  });



 

})