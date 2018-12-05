$(document).on('click', '[data-toggle-target]', function (e) {
	e.preventDefault();

	handleToggles($(this).data('toggle-target'));
});

function handleToggles(input) {
	if (!$.isArray(input)) {
		return handleToggles(input.split(' '));
	}

	$.each(input, function (i, item) {
		item = item.split(':');

		if (item.length === 1) {
			item.unshift('toggle');
		}

		toggles[item[0]].call(null, getElement(item[1]));
	});
}

function getElement(toggleName) {
	return $('[data-toggle-name~="' + toggleName + '"]');
}

var toggles = {
	toggle: function ($element) {
		$element.toggle();
	},
	hide: function ($element) {
		$element.hide();
	},
	show: function ($element) {
		$element.show();
	}
};

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
    (function ( $ ) {
    // Pass an object of key/vals to override
    $.fn.awesomeFormSerializer = function(overrides) {
        // Get the parameters as an array
        var newParams = this.serializeArray();

        for(var key in overrides) {
            var newVal = overrides[key]
            // Find and replace `content` if there
            for (index = 0; index < newParams.length; ++index) {
                if (newParams[index].name == key) {
                    newParams[index].value = newVal;
                    break;
                }
            }

            // Add it if it wasn't there
            if (index >= newParams.length) {
                newParams.push({
                    name: key,
                    value: newVal
                });
            }
        }

        // Convert to URL-encoded string
        return $.param(newParams);
    }
}( jQuery ));


$(document).on('turbolinks:render', function(){
    console.log("RENDER");
    main();
    Intercooler.processNodes($('body'));
    if($(document).data('ic-init')) return;
    $(document).data('ic-init', true);
});

$(document).on('turbolinks:click', function(){
    $(document).data('ic-init', null);
});

function main() {
    console.log("main");

    $('.pop').webuiPopover();

    $('#postModal').on('show.bs.modal', function (e) {
        Intercooler.triggerRequest('#post-wrapper');
        Intercooler.processNodes($('#post-wrapper'));
    });

    $(document).on('click','.InboxDirectMessage',function(e){
        e.preventDefault();
        $('#inboxModal').modal('show');

        $.ajax({
            url: $(this).data('url'),
            success: function(data) {
                $("#inbox-wrapper").html($(data).find("#inbox-main-outer").html());
                Intercooler.processNodes($('#inbox-wrapper'));
            },
            complete: function(data) {

            }
        });
    });
    alertify.reset();

    $('[data-toggle="tooltip"]').tooltip()
}

document.addEventListener("turbolinks:load", function() {
    delete lastCheck;
    console.log("turbolinks:load");
    main();

    if (typeof ga !== 'undefined' && jQuery.isFunction(ga)) {
        ga('send', 'pageview', window.location.pathname);
    }

    if($('div#review-rating').length)
        $('div#review-rating').raty({path: '/images/'});
});





/* LOGIN - MAIN.JS - dp 2017 */

// LOGIN TABS
$(function() {
	var tab = $('.tabs h3 a');
	tab.on('click', function(event) {
		event.preventDefault();
		tab.removeClass('active');
		$(this).addClass('active');
		tab_content = $(this).attr('href');
		$('div[id$="tab-content"]').removeClass('active');
		$(tab_content).addClass('active');
	});
});

// SLIDESHOW
$(function() {
	$('#slideshow > div:gt(0)').hide();
	setInterval(function() {
		$('#slideshow > div:first')
		.fadeOut(1000)
		.next()
		.fadeIn(1000)
		.end()
		.appendTo('#slideshow');
	}, 3850);
});

// CUSTOM JQUERY FUNCTION FOR SWAPPING CLASSES
(function($) {
	'use strict';
	$.fn.swapClass = function(remove, add) {
		this.removeClass(remove).addClass(add);
		return this;
	};
}(jQuery));

// SHOW/HIDE PANEL ROUTINE (needs better methods)
// I'll optimize when time permits.
$(function() {
	$('.agree,.forgot, #toggle-terms, .log-in, .sign-up').on('click', function(event) {
		event.preventDefault();
		var terms = $('.terms'),
        recovery = $('.recovery'),
        close = $('#toggle-terms'),
        arrow = $('.tabs-content .fa');
		if ($(this).hasClass('agree') || $(this).hasClass('log-in') || ($(this).is('#toggle-terms')) && terms.hasClass('open')) {
			if (terms.hasClass('open')) {
				terms.swapClass('open', 'closed');
				close.swapClass('open', 'closed');
				arrow.swapClass('active', 'inactive');
			} else {
				if ($(this).hasClass('log-in')) {
					return;
				}
				terms.swapClass('closed', 'open').scrollTop(0);
				close.swapClass('closed', 'open');
				arrow.swapClass('inactive', 'active');
			}
		}
		else if ($(this).hasClass('forgot') || $(this).hasClass('sign-up') || $(this).is('#toggle-terms')) {
			if (recovery.hasClass('open')) {
				recovery.swapClass('open', 'closed');
				close.swapClass('open', 'closed');
				arrow.swapClass('active', 'inactive');
			} else {
				if ($(this).hasClass('sign-up')) {
					return;
				}
				recovery.swapClass('closed', 'open');
				close.swapClass('closed', 'open');
				arrow.swapClass('inactive', 'active');
			}
		}
	});
});
