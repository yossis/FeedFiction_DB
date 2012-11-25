jQuery(document).ready(function($){
	
	/* ------------------- Fancybox --------------------- */

	(function() {

		$('[rel=image]').fancybox({
			type        : 'image',
			openEffect  : 'fade',
			closeEffect	: 'fade',
			nextEffect  : 'fade',
			prevEffect  : 'fade',
			helpers     : {
				title   : {
					type : 'inside'
				}
			}
		});

		$('[rel=image-gallery]').fancybox({
			nextEffect  : 'fade',
			prevEffect  : 'fade',
			helpers     : {
				title   : {
					type : 'inside'
				},
				buttons  : {},
				media    : {}
			}
		});


	})();
	
	
	/* ------------------- Client Carousel --------------------- */

	$('.clients-carousel').flexslider({
	    animation: "slide",
		easing: "swing",
	    animationLoop: true,
	    itemWidth: 1,
	    itemMargin: 1,
	    minItems: 1,
	    maxItems: 8,
		controlNav: false,
		directionNav: false,
		move: 2
      });


	/* ------------------ Back To Top ------------------- */

	jQuery('#footer-menu-back-to-top a').click(function(){
		jQuery('html, body').animate({scrollTop:0}, 300); 
		return false; 
	});
	

	/* --------------------- Tabs ------------------------ */	

		(function() {

			var $tabsNav    = $('.tabs-nav'),
				$tabsNavLis = $tabsNav.children('li'),
				$tabContent = $('.tab-content');

			$tabsNav.each(function() {
				var $this = $(this);

				$this.next().children('.tab-content').stop(true,true).hide()
													 .first().show();

				$this.children('li').first().addClass('active').stop(true,true).show();
			});

			$tabsNavLis.on('click', function(e) {
				var $this = $(this);

				$this.siblings().removeClass('active').end()
					 .addClass('active');

				$this.parent().next().children('.tab-content').stop(true,true).hide()
															  .siblings( $this.find('a').attr('href') ).fadeIn();

				e.preventDefault();
			});

		})();
		
			
});

/* ------------------ Tooltips ----------------- */

jQuery(document).ready(function() {

    $('.tooltips').tooltip({
      selector: "a[rel=tooltip]"
    })

});

/* ------------------ Progress Bar ------------------- */	

jQuery(document).ready(function($){
	
	$(".meter > span").each(function() {
		$(this)
		.data("origWidth", $(this).width())
		.width(0)
		.animate({
			width: $(this).data("origWidth")
		}, 1200);
	});
});

/* ------------------- Parallax --------------------- */

jQuery(document).ready(function($){
	
	$('#da-slider').cslider({
		autoplay	: true,
		bgincrement	: 50
	});

});

/* ------------------ Image Overlay ----------------- */

jQuery(document).ready(function () {
	
	$('.picture a').hover(function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link').stop().fadeTo('fast', 1);
	},function () {
		$(this).find('.image-overlay-zoom, .image-overlay-link').stop().fadeTo('fast', 0);
	});
	
});

/* -------------------- Isotope --------------------- */

jQuery(document).ready(function (){
	
	feedfiction.actions.renderBoxes();

	
});