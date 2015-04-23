(function($){
    $.fn.bottom = function(options) {

        var defaults = {
            // how close to the scrollbar is to the bottom before triggering the event
            proximity: 0
        };

        var options = $.extend(defaults, options);

        return this.each(function() {
            var obj = this;
            $(obj).bind("scroll", function() {
                if (obj == window) {
                    scrollHeight = $(document).height();
                }
                else {
                    scrollHeight = $(obj)[0].scrollHeight;
                }
                scrollPosition = $(obj).height() + $(obj).scrollTop();
                if ( (scrollHeight - scrollPosition) / scrollHeight <= options.proximity) {
                    $(obj).trigger("bottom");
                }
            });

            return false;
        });
    };
})(jQuery);