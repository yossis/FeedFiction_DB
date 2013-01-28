jQuery(document).ready(function($){
	
	 $('.modal').modalResponsiveFix({ debug: true });

	/* ------------------ Back To Top ------------------- */

	jQuery('#footer-menu-back-to-top a').click(function(){
		jQuery('html, body').animate({scrollTop:0}, 300); 
		return false; 
	});
	

	/* --------------------- Tabs ------------------------ */	

			
});

/* ------------------ Tooltips ----------------- */

jQuery(document).ready(function() {

    $('.tooltips').tooltip({
      selector: "a[rel=tooltip]"
    })

});



/* ------------------ Image Overlay ----------------- */

function imageOverlay(){
	$('.picture a').hover(function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link , .image-overlay-start').stop().fadeTo('fast', 1);
	},function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link , .image-overlay-start').stop().fadeTo('fast', 0);
	});
}

jQuery(document).ready(function () {
	
	imageOverlay();
	
});

/* -------------------- Isotope --------------------- */
function renderIsotope(tiles){
	var $container = $(tiles);


	$(tiles).imagesLoaded( function(){
		$(tiles).isotope({
			transformsEnabled: false,
	  // options
		  itemSelector : '.portfolio-item',
		  masonry: {
		    columnWidth: $container.width() / 12 
		    
		  }
		})
	});

	// $(tiles).imagesLoaded(function(){
        
 //                var $container = $(tiles);
 //                    $select = $('#filters select');

 //                // initialize Isotope
 //                $container.isotope({
 //                // options...
 //                resizable: false, // disable normal resizing
 //                // set columnWidth to a percentage of container width
 //                masonry: { columnWidth: $container.width() / 12 }
 //                });

 //                // update columnWidth on window resize
 //                $(window).smartresize(function(){
                
 //                    $container.isotope({
 //                    // update columnWidth to a percentage of container width
 //                    masonry: { columnWidth: $container.width() / 12 }
 //                    });
 //                });


 //                $container.isotope({
 //                    itemSelector : '.portfolio-item'
 //                });

 //                $select.change(function() {
                    
 //                    var filters = $(this).val();

 //                        $container.isotope({
 //                            filter: filters
 //                        });
                    
 //                    });

 //                    var $optionSets = $('#filters .option-set'),
 //                    $optionLinks = $optionSets.find('a');

 //                    $optionLinks.click(function(){
                    
 //                        var $this = $(this);
 //                        // don't proceed if already selected
 //                        if ( $this.hasClass('selected') ) {
 //                            return false;
 //                        }
 //                    var $optionSet = $this.parents('.option-set');
 //                    $optionSet.find('.selected').removeClass('selected');
 //                    $this.addClass('selected');

 //                    // make option object dynamically, i.e. { filter: '.my-filter-class' }
 //                    var options = {},
 //                        key = $optionSet.attr('data-option-key'),
 //                        value = $this.attr('data-option-value');
 //                    // parse 'false' as false boolean
 //                    value = value === 'false' ? false : value;
 //                    options[ key ] = value;
 //                    if ( key === 'layoutMode' && typeof changeLayoutMode === 'function' ) {
 //                      // changes in layout modes need extra logic
 //                      changeLayoutMode( $this, options )
 //                    } else {
 //                      // otherwise, apply new options
 //                      $container.isotope( options );
 //                    }

 //                    return false;
                    
 //                  });
                
 //            });
}

jQuery(document).ready(function (){
	renderIsotope('#portfolio-wrapper');
	
});