 jQuery(document).ready(function ($)  {
  // Prepare layout options.
  var options = {
    autoResize: true, // This will auto-update the layout when the browser window is resized.
    container: $('#story-container'),// Optional, used for some extra CSS styling
    offset: 15, // Optional, the distance between grid items
    itemWidth: 370 // Optional, the width of a grid item
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
    $('#start-story textarea').textareaCounter({title: '#start-story h3',submit:'#start-story .modal-footer input[type=submit]', enableSubmitAfterNumWords:10});

    $('#start-story').modal('toggle');

  });

  var continueStoryClick = $('');
  $(document).on("click", '#tiles li.continue-story div.tiels-items-container a.btn', function(e){
    var textarea = $(this).closest('li').find('textarea');
   //if ($(this).hasClass('continue-story')){
   // $(textarea).focus();
  // }
  }); 

  $(document).on("click", '#tiles li.continue-story textarea', function(e){
    if ($(this).attr('unlogged') && $(this).attr('unlogged').length>0){
      alert("You must sign in to complete the story!");
      $(this).blur();
      return;
    }

     var canvas = $(this).closest('li').find('.cs-canvas');
     var limit = $(this).attr('limit');
     var button = $(this).closest('li').find('div.continue-story-text input[type=submit]');
    $(this).textareaCounter({container: canvas, limit:limit, callback: function(e){
        if(e>0){
            $(button).addClass('btn-primary').removeAttr("disabled"); 
          }
          else{
            $(button).removeClass('btn-primary').attr('disabled','disabled');
          }
      }
    });
   
  }); 

});