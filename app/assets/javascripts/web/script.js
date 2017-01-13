$("document").ready(function() {
    // << ====================== Functions Calls ====================== >>
    highlightNavItem();
    styleConfirmModal();






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


    // --- this function is to add css class to the modal depending on the theme  ---
    function styleConfirmModal() {
        var confirmModal = $("#confirm_modal");
        var themeColor = $('div[class*="-theme"]').attr('class');
        if (themeColor) {
            themeColor = themeColor.split(" ");
            themeColor = themeColor[themeColor.length - 1];
            $(confirmModal).addClass(themeColor);
        }
    };







});
