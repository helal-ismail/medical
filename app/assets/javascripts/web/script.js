$("document").ready(function() {
    // << ====================== Functions Calls ====================== >>
    highlightNavItem();







    // << ====================== Functions Declaration ====================== >>

    // --- this function is to get the menu item that should be active and highlight it ---
    function highlightNavItem() {
        var navURL = window.location.href.toLowerCase();
        var allNavElements = $("ul.sidebar-menu li a");
        var activeListItem;

        $(allNavElements).each(function() {
            activeListItem = $(this).find('span').text().toLowerCase();
            $(this).parent().removeClass();
            if (navURL.indexOf(activeListItem) != -1) {
                $(this).parent().addClass("active");
                $(this).parent().addClass(activeListItem);
            }
        });
    };
});
