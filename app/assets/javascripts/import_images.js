 jQuery(document).ready(function ($)  {
  // Prepare layout options.
  var options = {
    autoResize: true, // This will auto-update the layout when the browser window is resized.
    container: $('#story-container'),// Optional, used for some extra CSS styling
    offset: 5, // Optional, the distance between grid items
    itemWidth: 250 // Optional, the width of a grid item
  };
  
  // Get a reference to your grid items.
  var handler = $('#tiles li');
  
  // Call the layout function.
  handler.wookmark(options);
  
  // Capture clicks on grid items.
  //var button = $('#tiles li.story-box div.tiels-items-container a.btn');
  //$(document).on("click", '#tiles li.story-box div.tiels-items-container a.btn', function(){ alert("Goodbye!"); });  
  var startStoryClick = $('#tiles li.container-ss');
  startStoryClick.click(function(e){
    e.stopPropagation();
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
    $('#start-story .ss-feed-form input[type=hidden].ss-image').attr('value', image);
    $('#start-story textarea').textareaCounter({title: '#start-story h3'});

    $('#start-story').modal('toggle');

  });

  var continueStoryClick = $('');
  $(document).on("click", '#tiles li.continue-story div.tiels-items-container a.btn', function(e){
    var textarea = $(this).closest('li').find('textarea');
   if ($(this).hasClass('continue-story')){
    $(textarea).focus();
   }
  }); 

  $(document).on("click", '#tiles li.continue-story textarea', function(e){
     var canvas = $(this).closest('li').find('.cs-canvas');
    $(this).textareaCounter({container: canvas});
   
  }); 



});