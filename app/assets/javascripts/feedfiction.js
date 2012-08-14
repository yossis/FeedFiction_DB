/* This file contains generic snet functions that are available regardless of current context. */
var feedfiction = {
    constants: {
        
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
       
    },
    /*
    *   userFunction - Meant for functions such as blocking users, adding to favorites, etc.
    */
    userFunction: function () {
        if (arguments.length == 0) return;
        var type = arguments[0];
        var args = Array.prototype.slice.call(arguments, 1);
        if (snet.actions[type] != null) snet.actions[type].apply(this, args);
    },
    /*
    *   validateField - generic field validation function
    */
    validateField: function () {
        
    },
    /*
    *   init - Sets default links for userFunctions
    */
    init: function () {
        $('.userFunction').live('click', function (e) {
            var rel = $(this).attr('data-function');
            if (rel != null) {
                e.preventDefault();
                var combo = rel.split('#');
                snet.userFunction.apply(this, combo);
            }
        });

       
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
     
