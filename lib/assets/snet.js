/* This file contains generic snet functions that are available regardless of current context. */
var snet = {
    constants: {
        messageTitle: 'Alert',
        profileTitle: 'Profile Card',
        imageTitle: 'Image',
        profileUrl: 'http://www.s-net.co.il/Handlers/ProfileHandler.aspx',
        actionUrl: 'http://www.s-net.co.il/Handlers/ActionsHandler.ashx',
        userId: 0
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
        openLightbox: function () {
            var url = $(this).attr('href');
            var title = $(this).attr('title');
            $('#cboxExtraTitle').remove();
            $.colorbox({ title: title, href: url });
        },
        /*
        *   forgotPassword - opens a modal dialog for recovering the password
        */
        forgotPassword: function () {
            var form = snet.actions._passwordForm;
            if (form == null) {
                form = $('#hiddenModals .forgetPasswordModal').clone();
                form.click(function (e) { e.stopPropagation(); });
                $('input[type=submit]', form).click(submit);
                $('.modal-close', form).click(function () { $(form).remove(); });
                $(document.body).append(form);
                form.draggable();
            }
            $('#recover-email', form).val($('#username').val());

            function submit(e) {
                e.stopPropagation();
                var email = $('#recover-email', form).val();
                if (email != '' && (/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i).test(email)) {
                    $(form).addClass('loading');
                    $.ajax({
                        url: snet.constants.actionUrl,
                        data: {
                            func: "RecoverPassword",
                            email: email
                        },
                        dataType: 'json',
                        success: function (data) {
                            $(form).removeClass('loading');
                            if (data == null) {
                                alert("The request failed to send.");
                            } else if (data.success == false) {
                                alert(data.message);
                            } else {
                                $(form).remove();
                                snet.actions.displayMessage(data.message, snet.constants.messages.success);
                            }
                        },
                        error: function () {
                            $(form).removeClass('loading');
                            snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                        }
                    });
                } else {
                    snet.actions.displayMessage("Please enter a valid email address.", snet.constants.messages.error);
                }
                return false;
            }
        },
        _passwordForm: null,
        /*
        *   deletes the Saved Search of a given id
        */
        deleteSavedSearch: function (id) {
            if (confirm("Are you sure you want to delete this saved search?")) {
                $('#saved-search-' + id).addClass('loading');
                $.ajax({
                    url: snet.constants.actionUrl,
                    data: {
                        func: "DeleteSavedSearch",
                        searchId: id
                    },
                    dataType: 'json',
                    success: function (data) {
                        $('#saved-search-' + id).removeClass('loading');
                        if (data == null) {
                            alert("The request failed to send.");
                        } else if (data.success == false) {
                            alert(data.message);
                        } else {
                            $('#saved-search-' + id).remove();
                        }
                    },
                    error: function () {
                        $('#saved-search-' + id).removeClass('loading');
                        snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                    }
                });
            }
        },
        /*
        *   deletes the messages - accepts a comma-delimited list of message ids
        */
        deleteMessage: function (ids, onSuccess) {
            var success = false;
            if (ids == null || ids == '' || ids.length == 0) {
                alert(snet.constants.messages.validateCheckDelMsg);
                return success;
            }
            if (confirm(snet.constants.messages.validateDeleteMsg)) {
                $.ajax({
                    url: snet.constants.actionUrl,
                    data: {
                        func: "DeleteMessage",
                        mId: ids
                    },
                    dataType: 'json',
                    success: function (data) {
                        if (data == null) {
                            alert("The request failed to send.");
                        } else if (data.success == false) {
                            alert(data.message);
                        } else {
                            ids = ids.split(',');
                            for (var c = 0; c < ids.length; c++) {
                                $('*[data-messageid="' + ids[c] + '"').remove();
                            }
                            success = true;

                            if (onSuccess) setTimeout(onSuccess, 100);
                        }
                    },
                    error: function () {
                        snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                    }
                });

            }
            return success;
        },
        /*
        *   displayMessage - opens a simple modal box with a message in it
        */
        displayMessage: function (text, title) {
            if (title == null) title = snet.constants.messageTitle;
            $('#cboxExtraTitle').remove();
            var width = arguments.length > 2 ? arguments[2] : 'false';

            $.colorbox({ title: title, html: '<div class="modalMessage">' + text + '</div>', opacity: 0.5, width: width });
        },
        /*
        *   view - opens a lightbox for displaying a profile
        */
        view: function (memberId) {
            $('#cboxExtraTitle').remove();
            $.colorbox({ title: snet.constants.profileTitle, href: snet.constants.profileUrl + '?UserId=' + memberId, opacity: 0.5, onComplete: function () {
                $('#cboxLoadedContent #cboxExtraTitle').insertBefore($('#cboxClose'));
                $('#cboxTitle').html($('#profileTitle'));
            }
            });
        },
        /*
        *
        */
        openFrame: function (memberId) {
            updateFrame(memberId);
        },

        /*
        *   displayImage - opens a lightbox for displaying an image
        */
        displayImage: function (url) {
            if (url == null) url = $(this).attr('data-displayImage');
            if (url == null) url = $(this).attr('src');
            if (url == null || url == '') return;

            url = '<img src="' + url + '" alt="" />';

            var title = $(this).attr('title') || $(this).attr('alt') || snet.constants.imageTitle;

            snet.simpleModal({ title: title, html: url });
        },
        /*
        *   sendMessage - opens a modal dialog for writing a message to a user
        */
        sendMessage: function (id, name, replyToId, reject) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            if ($('.messageModal', this).length > 0) return;
            var form = $('#hiddenModals .messageModal').clone();
            form.click(function (e) { e.stopPropagation(); });
            if (reject != undefined && reject.length > 0) {
                $('.modal-title', form).text($('.modal-title .refused-text', form).text());

            }
            $('input[name=message-to]', form).val(name || id).attr('readonly', 'readonly');
            $('input[type=submit]', form).click(submit);
            $('.modal-close', form).click(function () { form.remove(); });

            if (replyToId != null && !isNaN(replyToId) && $('.message-head[data-messageid="' + replyToId + '"]').length > 0) {
                // This is a reply, so override title
                $('input[name=message-subject]', form).val('RE:' + $.trim($('.message-head[data-messageid="' + replyToId + '"]').text()));
                $('textarea[name=message-body]', form).val(reject);
            }

            $(this).css('position', 'relative');

            $(this).append(form);
            //            if ($('.profile-card').length > 0) {
            //                $('.profile-card .modal').css({ 'clear': 'both', 'margin': '0 auto' });
            //            }

            function submit(e) {
                e.stopPropagation();
                if ($('input[name=message-to]', form).val().length > 0 &&
                    $('input[name=message-subject]', form).val().length > 0) {
                    $(form).addClass('loading');
                    var data = {
                        func: "SendMessage",
                        hasEmail: ($('input[value=email]', form).prop('checked') ? 1 : 0),
                        msg: $('textarea[name=message-body]', form).val(),
                        subj: $('input[name=message-subject]', form).val(),
                        userId: id,
                        hasRecommender1: ($('input[name=recommender-1]', form).prop('checked') ? $('input[name=recommender-1]', form).val() : 0),
                        hasRecommender2: ($('input[name=recommender-2]', form).prop('checked') ? $('input[name=recommender-2]', form).val() : 0),
                        hasRecommender3: ($('input[name=recommender-3]', form).prop('checked') ? $('input[name=recommender-3]', form).val() : 0)
                    };
                    if (replyToId != null && !isNaN(replyToId)) data.repliedTo = replyToId;
                    $.ajax({
                        url: snet.constants.actionUrl,
                        data: data,
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            $(form).removeClass('loading');
                            if (data == null) {
                                alert("The message failed to send.");
                            } else if (data.success == false) {
                                alert(data.message);
                            } else {
                                $(form).remove();
                                snet.actions.displayMessage(data.message, snet.constants.messages.messageSent, '500px');
                            }
                        },
                        error: function () {
                            $(form).removeClass('loading');
                            alert("An error has occurred contacting the server.", snet.constants.messages.failed);
                        }
                    });
                } else {
                    alert(snet.constants.messages.validateSendMsg);
                }
                return false;
            }
        },
        refusedMessage: function () {
            if (arguments.length == 0) return;

            var reject = snet.constants.refusedContent.replace(/%BL%/gi, '\n').replace('%NAME%', arguments[1]);
            Array.prototype.push.call(arguments, reject);
            snet.actions.sendMessage.apply(this, arguments);

        },
        openChat: function (id, name) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            } 
            parent.chatController.push(name, id, '', snet.constants.currentName, '', '');
        },
        /*
        *   sendWishes - opens a modal dialog for sending a birthday well-wishing
        */
        sendWishes: function (id, name) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }

            snet.actions.displayMessage("Sending birthday blessing...", "Send wishes to:" + name);

            $.ajax({
                url: snet.constants.actionUrl,
                data: {
                    func: "SendWishes",
                    SenderId: snet.constants.userId,
                    toUserId: id
                },
                dataType: 'json',
                success: function (data) {
                    if (data == null) {
                        alert("The abuse report failed to send.");
                    } else if (data.success == false) {
                        alert(data.message);
                    } else {
                        snet.actions.displayMessage("Birthday blessing has been sent successfully!", "Send wishes to:" + name);
                    }
                },
                error: function () {
                    $(form).removeClass('loading');
                    alert("An error has occurred contacting the server.", snet.constants.messages.failed);
                }
            });
        },
        /*
        *   reportAbuse - opens a modal dialog for reporting abuse by a user
        */
        reportAbuse: function (reportType, targetId, reportedUserId, name) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            if ($('.messageModal', this).length > 0 && $('.messageModal', this).parent('#hiddenModals').length == 0) return;
            var form = $('#hiddenModals .messageModal').clone();
            form.click(function (e) { e.stopPropagation(); });
            $('.modal-title', form).text($('.modal-title .abuse-text', form).text());
            $('input[name=message-to]', form).val('Administrator').attr('readonly', 'readonly');
            $('input[name=message-subject]', form).val('Abuse report on ' + (name || targetId)).attr('readonly', 'readonly');
            $('input[type=submit]', form).click(submit);
            $('.modal-close', form).click(function () { form.remove(); });

            $(this).css('position', 'relative');
            $(this).append(form);

            function submit(e) {
                e.stopPropagation();
                if ($('input[name=message-to]', form).val().length > 0 &&
                    $('input[name=message-subject]', form).val().length > 0) {
                    $(form).addClass('loading');
                    $.ajax({
                        url: snet.constants.actionUrl,
                        data: {
                            func: "ReportAbuse",
                            hasEmail: ($('.message .additional[value=email]', form).prop('checked') ? 1 : 0),
                            msg: $('textarea[name=message-body]', form).val(),
                            targetId: targetId,
                            reportedUserId: reportedUserId,
                            reportType: reportType
                        },
                        type: 'post',
                        dataType: 'json',
                        success: function (data) {
                            $(form).removeClass('loading');
                            if (data == null) {
                                alert("The abuse report failed to send.");
                            } else if (data.success == false) {
                                alert(data.message);
                            } else {
                                $(form).remove();
                                snet.actions.displayMessage(data.message, "Abuse report sent!");
                            }
                        },
                        error: function () {
                            $(form).removeClass('loading');
                            alert("An error has occurred contacting the server.", snet.constants.messages.failed);
                        }
                    });
                } else {
                    alert(snet.constants.messages.failed.validateSendMsg);
                }
                return false;
            }
        },

        /*
        *   sendMessage - opens a modal dialog for writing a message to a user
        */
        blockMember: function (id, type, sendMessage) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            if (type == null) {
                if ($(this).hasClass('block-member')) type = "block";
                else if ($(this).hasClass('unblock-member')) type = "unblock";
            }
            var ele = this;
            $.ajax({
                url: snet.constants.actionUrl,
                data: {
                    func: "SetUserBlock",
                    type: type,
                    userId: id
                },
                success: function () {
                    switch (type) {
                        case 'block':
                            if (sendMessage != null && sendMessage.toString() == "true") snet.actions.displayMessage("You have successfully blocked this user.", "Success!");
                            $(ele).removeClass('block-member').addClass('unblock-member');
                            break;
                        case 'unblock':
                            if (sendMessage != null && sendMessage.toString() == "true") snet.actions.displayMessage("You have unblocked this user.", "Success!");
                            $(ele).removeClass('unblock-member').addClass('block-member');
                            break;
                    }
                },
                error: function () {
                    snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                }
            });
        },
        /*
        *   sendMessage - opens a modal dialog for writing a message to a user
        */
        addFavorite: function (id) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            var type = "";
            if ($(this).hasClass('add-favorite')) type = "favorite";
            else if ($(this).hasClass('remove-favorite')) type = "unfavorite";
            var ele = this;
            $.ajax({
                url: snet.constants.actionUrl,
                data: {
                    func: "SetUserFavorite",
                    type: type,
                    userId: id
                },
                success: function () {
                    switch (type) {
                        case 'favorite':
                            $(ele).removeClass('add-favorite').addClass('remove-favorite');
                            break;
                        case 'unfavorite':
                            $(ele).removeClass('remove-favorite').addClass('add-favorite');
                            break;
                    }
                },
                error: function () {
                    snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                }
            });
        },
        /*
        *   blockMember - opens a modal dialog for writing a message to a user
        */
        setAccessPhotos: function (id) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            var type = "";
            if ($(this).hasClass('grant-photo')) type = "grant";
            else if ($(this).hasClass('deny-photo')) type = "deny";

            var ele = this;
            $.ajax({
                url: snet.constants.actionUrl,
                data: {
                    func: "SetAccessToPrivatePhotos",
                    type: type,
                    userId: id
                },
                success: function (data) {
                    switch (type) {
                        case 'grant':
                            snet.actions.displayMessage(data.message, "הודעה!");
                            $(ele).removeClass('grant-photo').addClass('deny-photo');
                            break;
                        case 'deny':
                            snet.actions.displayMessage(data.message, "הודעה!");
                            $(ele).removeClass('deny-photo').addClass('grant-photo');
                            break;
                    }
                },
                error: function () {
                    snet.actions.displayMessage("הודעת שגיאה:", snet.constants.messages.failed);
                }
            });
        },
        /*
        *   sendMessage - opens a modal dialog for writing a message to a user
        */
        viewHistory: function (id) {
            if (snet.constants.userId == 0) {
                alert(snet.constants.messages.validateInertSystem);
                return;
            }
            $.ajax({
                url: snet.constants.actionUrl,
                data: {
                    func: "GetChatHistory",
                    userId: id
                },
                success: displayHistory,
                error: function () {
                    snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                }
            });

            function displayHistory(data) {
                if (data == null || data.success == false || data.data == null) {
                    snet.actions.displayMessage("An error has occurred contacting the server.", snet.constants.messages.failed);
                    return;
                }
                else if (data.data.length == 0) {
                    snet.actions.displayMessage("You have no history with this user.", "Chat History");
                    return;
                }

                location.href = data.message;
            }
        }
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
        var success = true, message = '', el = $(this);
        el.removeClass('input-error');
        if (el.siblings('.error')) {
            el.siblings('.error').html('');
        }
        if (el.val() == '' || this.nodeName != null && this.nodeName.toLowerCase() == 'select' && el.val() == '0') {
            if (el.hasClass('required')) {
                success = false;
                message = snet.constants.messages.required;
            }
        } else {
            if (el.hasClass('validate-match') && el.val() != $('#' + el.attr('data-matchInput')).val()) {
                success = false;
                message = snet.constants.messages.mustMatch.replace('%FIELD%', el.attr('data-matchName'));
            } else if (el.hasClass('alphaNumFix') && !(/^[א-תa-zA-Z0-9_]+$/).test(el.val())) {
                success = false;
                message = snet.constants.messages.alphaHebNumFix;
            } else if (el.hasClass('validate-date') && isNaN(Date.parse(el.val()))) {
                success = false;
                message = snet.constants.messages.dateInvalid;
            } else if (el.hasClass('alphaHeb') && !(/^[א-תa-zA-Z]+$/).test(el.val())) {
                success = false;
                message = snet.constants.messages.alphaHebFix;
            } else if (el.hasClass('validate-email') && !(/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i).test(el.val())) {
                success = false;
                message = snet.constants.messages.emailInvalid;
            } else if (el.hasClass('validate-required-check') && !this.checked) {
                success = false;
                message = snet.constants.messages.required;
            } else if (!isNaN(el.attr('data-minLength')) && parseInt(el.attr('data-minLength')) > el.val().length) {
                success = false;
                message = snet.constants.messages.minLength.replace('%NUM%', el.attr('data-minLength'));
            } else if (!isNaN(el.attr('data-maxLength')) && parseInt(el.attr('data-maxLength')) < el.val().length) {
                success = false;
                message = snet.constants.messages.maxLength.replace('%NUM%', el.attr('data-maxLength'));
            }
        }
        if (!success) {
            el.focus();
            el.addClass('input-error');
            if (el.siblings('.error-message').length > 0) {
                el.siblings('.error-message').html(message);
            }
            else snet.actions.displayMessage(message, "Error!");
        } else {
            if (el.siblings('.error-message')) {
                el.siblings('.error-message').html('');
            }
        }

        return success;
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

        $('.datepicker').datepicker({ 'dateFormat': 'dd/mm/yy', changeMonth: true, changeYear: true, yearRange: 'c-100:c+100' });

        $('input,textarea').live('blur', snet.validateField);

        $('select').live('change', snet.validateField);

        $('snet').live('blur', function () {
            var success = true, message = '', el = $(this);
            el.removeClass('input-error');
            if (el.siblings('.error').length > 0) {
                if (el.sibling('.error span').length > 0) {
                    el.sibling('.error span').text('');
                } else {
                    el.siblings('.error').text('');
                }
            }
            if (el.hasClass('required') && (el.val() == '' || el.val() == 0)) {
                el.addClass('input-error');
                success = false;
                message = snet.constants.messages.required;
            }
            if (!success) {
                el.addClass('input-error');
                if (el.siblings('.error-message').length > 0) {
                    el.siblings('.error-message').html(message);
                }
                else snet.actions.displayMessage(message, "Error!");
            } else {
                if (el.siblings('.error-message')) {
                    el.siblings('.error-message').html('');
                }
            }
        });

        //        $('.message-head').live('click', function (e) {
        //            e.stopPropagation();

        //            $(this).next('.message-body').toggle();

        //            if ($(this).hasClass('unread')) {
        //                $(this).removeClass('unread');
        //                $.ajax({
        //                    url: snet.constants.actionUrl,
        //                    data: {
        //                        func: "ReadReport",
        //                        mId: $(this).attr('data-messageid')
        //                    }
        //                });
        //            }
        //        });
        $('.message-head input[name="selectedMail"]').live('click', function (e) {
            e.stopPropagation();
        });

        $('.sliding-pager-body').delegate('.sliding-pager-item', 'hover', function () {
            $(this).effect("highlight", {}, 1000);
        });

        //        $('.sliding-pager-body .sliding-pager-item').hover(function () {
        //            $(this).effect("highlight", {}, 3000);
        //            // $(this).fadeOut(100); $(this).fadeIn(500);
        //        });

        $('.sliding-pager').each(function () {
            var width = $(this).width() + parseInt($('.sliding-pager-item', this).css('margin-left')) + parseInt($('.sliding-pager-item', this).css('margin-right'));
            var items = $('.sliding-pager-item', this).length;
            var ul = $('.sliding-pager-body>ul', this);
            ul.css('width', (width * items) + 'px').css('display', 'block');

            var currentPage = 0;
            $(this).delegate('.sliding-pager-left', 'click', function () {
                if (currentPage < items - 1) {
                    currentPage++;
                }
                ul.animate({ right: '-' + (currentPage * width) + 'px' }, 300);
            });
            $(this).delegate('.sliding-pager-right', 'click', function () {
                if (currentPage > 0) {
                    currentPage--;
                }
                ul.animate({ right: '-' + (currentPage * width) + 'px' }, 300);
            });
        });

        if ($('.statistics').length != 0 || $('#mailOptions').length != 0) {
            snet.getStatistics();
            snet._statsInterval = setInterval(snet.getStatistics, 15000);
        }
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
    simpleModal: function (settings) {
        if (snet._modal == null) {
            snet._modal = $('#hiddenModals .simpleModal').clone();
            snet._modal.click(function (e) { e.stopPropagation(); });
            $('.modal-close', snet._modal).click(function () { snet._modal.remove(); snet._modal = null; });

            $(document.body).append(snet._modal);

            snet._modal.draggable();
            snet._modal.css("left", ($(window).width() - snet._modal.width()) / 2 + "px");
            snet._modal.css("top", ($(window).height() - snet._modal.height()) / 6 + "px");

        }
        if (settings.title) $('.modal-title', snet._modal).html(settings.title);
        if (settings.html) $('.modal-body', snet._modal).html(settings.html);
    },
    _modal: null,
    getStatistics: function () {
        $.ajax({
            url: snet.constants.actionUrl,
            data: {
                func: "GetStatisticsOnline"
            },
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data != null && data.success == true) {
                    var obj = $.parseJSON(data.message);
                    if (obj != null) {
                        //obj.AllMessagesCount;
                        $('.welcome .messageCount').text(obj.NotReadableMessage);
                        $('.welcome .messageStatus span.not-readable').text(obj.NotReadableMessage);
                        $('.statistics .message-count .stat').html('[' + (obj.AllMessagesCount > 0 ? ('<a href="' + snet.constants.sitePath + 'Mail.aspx?folder=Inbox">' + obj.AllMessagesCount + '</a>') : '0') + ']')
                        $('.statistics .favorites .stat').html('[' + (obj.MyFavoritesCount > 0 ? ('<a href="' + snet.constants.sitePath + 'Results/Favorites">' + obj.MyFavoritesCount + '</a>') : '0') + ']');
                        $('.statistics .blocked .stat').html('[' + (obj.MyBlockedCount > 0 ? ('<a href="' + snet.constants.sitePath + 'Results/Blocked">' + obj.MyBlockedCount + '</a>') : '0') + ']');
                        $('.statistics .viewed-my-profile .stat').html('[' + (obj.ViewedMyProfile > 0 ? ('<a href="' + snet.constants.sitePath + 'Results/Viewed">' + obj.ViewedMyProfile + '</a>') : '0') + ']');
                        $('.statistics .watching .stat').html('[' + (obj.WatchedProfile > 0 ? ('<a href="' + snet.constants.sitePath + 'Results/Watched">' + obj.WatchedProfile + '</a>') : '0') + ']');
                    }
                    var messages = $.parseJSON(data.data);
                    if (messages != null) {
                        $.each(messages ,function(i, item) {
                            parent.chatController.push(item.SenderDisplayName, item.SenderUserId, item.SenderDisplayName, snet.constants.currentName, '', item.Text);
                            
                        });
                    }

                }
            }
        });
    },
    _statsInterval: null
};

$(document).ready(snet.init);


//viewArticles: function (id) {
//                    if (data == null) {
//                        alert("The abuse report failed to send.");
//                    } else if (data.success == false) {
//                        alert(data.message);
//                    } else {
//                        snet.actions.displayMessage("Birthday blessing has been sent successfully!", "Send wishes to:" + name);
//                    }
//                },
//                error: function () {
//                    $(form).removeClass('loading');
//                    alert("An error has occurred contacting the server.", snet.constants.messages.failed);
//                }
//            });
//        },