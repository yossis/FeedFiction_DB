/* This file contains generic feedfiction functions that are available regardless of current context. */
var feedfiction = {
    constants: {
        messages:{
            required: 'required',
            
        }
        
    },
    /*
    *   actions - an object holding the various user functions
    *       Meant to be used in conjunction with the class="userFunction" and data-function="functionName_arguments" style
    */
    actions: {
        /*
        *   opens the link in a lightbox instead of in the window
        *   It uses the href and title parts of the link.
        */
        continueStory:function(id) {
            //Change form
            //var form = $('#story-'+id).find('form');
            //$(form).attr('action','/story_lines');
            //$(form).attr('id','new_story_line');

           
        },

        addPreloader:function(obj,element,message,cssClass) {
            if (obj)
                $(obj).attr('disabled','disabled');
            if (message==null)
                    message = 'loading..';
            if (cssClass==null)
                    cssClass = 'loading';
            if (element == null) {
                element = $(obj).add('<span>'+message+'</span>').addClass(cssClass);
            }
            else{
                $(element).addClass(cssClass);
            }
        },

        removePreloader:function(obj,cssClass,element){
            if (obj){
                $(obj).removeAttr('disabled');
            }
            if (cssClass == null) {
                cssClass='loading';
            }
            if (element == null) {
                $(obj).not(cssClass);
                }
            else{
                $(element).removeClass(cssClass);
            }
        },

        clearCommentText: function(){
            $('.add-comment textarea').val('');
         },

        validateComment: function(e){
            if (!feedfiction.validateLogin.call(this,'You must sign in to add comment'))
                return;

            var obj = $(this);
            var button = $(this).closest('div.add-comment').find('input[type=submit]');

            obj.keyup(function() {
                text = obj.val();
                charCount = $.trim(text).length;
                if(charCount > 1) {
                    $(button).addClass('btn-primary').removeAttr("disabled"); 
                }
                else{
                    $(button).removeClass('btn-primary').attr('disabled','disabled');
                }
            });
        },

        boldWriterLine: function(){
            var className = $(this).attr('class');
            var elements = $(this).closest('.story-with-owners').find('.'+className);

            $(elements).bind({
              mouseenter: function() {
                $(elements).css('background-color','yellow')
              },
              mouseleave: function() {
                $(elements).css('background-color','white')
              }
            });
        }


    },
    /*
    *   userFunction - Meant for functions such as blocking users, adding to favorites, etc.
    */
    userFunction: function () {
        if (arguments.length == 0) return;
        var type = arguments[0];
        var args = Array.prototype.slice.call(arguments, 1);
        if (feedfiction.actions[type] != null) feedfiction.actions[type].apply(this, args);
    },
    /*
    *   validateField - generic field validation function
    */
     validateField: function () {
        var success = true, message = '', el = $(this);
        el.removeClass('input-error');
        if (el.siblings('.error')) {
            el.siblings('.error').html('');
        }
        if (el.val() == '' || this.nodeName != null && this.nodeName.toLowerCase() == 'select' && el.val() == '0') {
            if (el.hasClass('required')) {
                success = false;
                message = feedfiction.constants.messages.required;
            }
        } else {
            if (el.hasClass('validate-match') && el.val() != $('#' + el.attr('data-matchInput')).val()) {
                success = false;
                message = feedfiction.constants.messages.mustMatch.replace('%FIELD%', el.attr('data-matchName'));
            } else if (el.hasClass('alphaNumFix') && !(/^[א-תa-zA-Z0-9_]+$/).test(el.val())) {
                success = false;
                message = feedfiction.constants.messages.alphaHebNumFix;
            } else if (el.hasClass('validate-date') && isNaN(Date.parse(el.val()))) {
                success = false;
                message = feedfiction.constants.messages.dateInvalid;
            } else if (el.hasClass('alphaHeb') && !(/^[א-תa-zA-Z]+$/).test(el.val())) {
                success = false;
                message = feedfiction.constants.messages.alphaHebFix;
            } else if (el.hasClass('validate-email') && !(/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i).test(el.val())) {
                success = false;
                message = feedfiction.constants.messages.emailInvalid;
            } else if (el.hasClass('validate-required-check') && !this.checked) {
                success = false;
                message = feedfiction.constants.messages.required;
            } else if (!isNaN(el.attr('data-minLength')) && parseInt(el.attr('data-minLength')) > el.val().length) {
                success = false;
                message = feedfiction.constants.messages.minLength.replace('%NUM%', el.attr('data-minLength'));
            } else if (!isNaN(el.attr('data-maxLength')) && parseInt(el.attr('data-maxLength')) < el.val().length) {
                success = false;
                message = feedfiction.constants.messages.maxLength.replace('%NUM%', el.attr('data-maxLength'));
            }
        }
        if (!success) {
            el.focus();
            el.addClass('input-error');
            if (el.siblings('.error-message').length > 0) {
                el.siblings('.error-message').html(message);
            }
            else feedfiction.actions.displayMessage(message, "Error!");
        } else {
            if (el.siblings('.error-message')) {
                el.siblings('.error-message').html('');
            }
        }

        return success;
    },

    validateLogin: function(message){
        var success = true;
        if ($(this).attr('unlogged') && $(this).attr('unlogged').length>0){
          success = false;
          alert(message);
          $(this).blur();
        }
        return success;
    },
    /*
    *   init - Sets default links for userFunctions
    */
    init: function () {
        $('.userFunction').on('click', function (e) {
            var rel = $(this).attr('data-function');
            if (rel != null) {
                e.preventDefault();
                var combo = rel.split('#');
                feedfiction.userFunction.apply(this, combo);
            }
        });

        $('input,textarea').on('blur', feedfiction.validateField);
        $('.story-with-owners span').on('hover', feedfiction.actions.boldWriterLine);
        //var storyBox = '#tiles li.continue-story';
        //$(storyBox).on('click', function(e) {
        //    url = $(this).attr('id').split('-')[1];
        //    location.href = 'stories/'+url;
        //});
        //$('select').live('change', feedfiction.validateField);

       
    },
    post_to_url: function (path, params, method) {
        method = method || "post"; // Set method to post by default, if not specified.

        // The rest of this code assumes you are not using a library.
        // It can be made less wordy if you use one.
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", path);

        for (var key in params) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);

            form.appendChild(hiddenField);
        }

        document.body.appendChild(form);    // Not entirely sure if this is necessary
        form.submit();
    },
    
};

$(document).ready(feedfiction.init);
     
