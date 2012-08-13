/**
 * jQuery.textareaCounter
 * Version 1.0
 * Copyright (c) 2011 c.bavota - http://bavotasan.com
 * Dual licensed under MIT and GPL.
 * Date: 10/20/2011
**/
(function($){
	$.fn.textareaCounter = function(options) {
		// setting the defaults
		// $("textarea").textareaCounter({ limit: 100 });
		var defaults = {
			limit: 55,
			container : null,
			title:null
		};	
		var options = $.extend(defaults, options);
 
		// and the plugin begins
		return this.each(function() {
			var obj, text, wordcount, limited;
 
			obj = $(this);
			var counterText = $(obj).parent().children('.counter-text');
			if (counterText.length==0)
				obj.after('<span style="font-size: 11px; clear: both; margin-top: 3px; display: block;" class="counter-text">Max. '+options.limit+' words</span>');
 
 			counterText = $(obj).parent().children('.counter-text');

			obj.keyup(function() {
			    text = obj.val();

			    if(text === "") {
			    	wordcount = 0;
			    } else {
				    wordcount = $.trim(text).split(" ").length;
				}

				// Set title
				if (wordcount < 5 &options.title !=null)
				{
					$(options.title).html(obj.val());
				}

			    if(wordcount > options.limit) {
			        $("#counter-text").html('<span style="color: #DD0000;">0 words left</span>');
					limited = $.trim(text).split(" ", options.limit);
					limited = limited.join(" ");
					$(this).val(limited);

			    } else {
			    	if (options.container!=null){
						$(options.container).html(obj.val());
					}
			        $(counterText).html((options.limit - wordcount)+' words left');
			    } 
			});
		});
	};
})(jQuery);