 jQuery(document).ready(function ($)  {
  // Prepare layout options.
  var options = {
    autoResize: true, // This will auto-update the layout when the browser window is resized.
    container: $('#story-container'), // Optional, used for some extra CSS styling
    offset: 2, // Optional, the distance between grid items
    itemWidth: 210 // Optional, the width of a grid item
  };
  
  // Get a reference to your grid items.
  var handler = $('#tiles li');
  
  // Call the layout function.
  handler.wookmark(options);
  
  // Capture clicks on grid items.
  handler.click(function(e){
    // Randomize the height of the clicked item.
    //var newHeight = $('img', this).height() + Math.round(Math.random()*300+30);
    //$(this).css('height', newHeight+'px');

    //Open new LightBox with start story component 
    
    // Update the layout.
    //handler.wookmark();
    var image = $('img', this).attr('src');
    if ($('#start-story .ss-image img').length >0) {
      $('#start-story .ss-image img').attr('src', image);
    }
    else
    {
      $('#start-story .ss-image').append('<img width="200" src="'+image+'"/>');
    }
    $('#start-story textarea').textareaCounter({title: '#start-story h3'});


    $('#start-story').modal('toggle');

  });
});