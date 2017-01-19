$("document").ready(function() {

    // << ====================== Functions Calls ====================== >>
    highlightNavItem();
    styleConfirmModal();

    // -- datepicker for the appoinments page --
    //$("#app_date").datepicker().datepicker("setDate", new Date());
    $("#app_date").datepicker({
        dateFormat: 'yy-mm-dd'
    });
    $("#app_date").datepicker().datepicker('setDate', 'today');

    $('.table').DataTable({
        bFilter: false,
        bLengthChange: false,
        bSort: false,
        pageLength: 20,
        oLanguage: {
            "oPaginate": {
                "sNext": '&gt>',
                "sLast": '&raquo;>>',
                "sFirst": '&laquo;<<',
                "sPrevious": '&lt;<'
            },
            "sInfo": "_START_ - _END_ of _TOTAL_"
        }
    });



    // << ====================== EVENTs ====================== >>

    $("#view_appointments").click(function() {
        // -- remove actions if selected date < today's date --
        var todaysDate = new Date();
        var datePickerVal = $("#app_date").val();
        datePickerVal = datePickerVal.split('-');
        var temp = datePickerVal[1];
        datePickerVal[1] = datePickerVal[2];
        datePickerVal[2] = temp;
        datePickerVal = datePickerVal[2] + "-" + datePickerVal[1] + "-" + datePickerVal[0];
        datePickerVal = new Date(datePickerVal);
        if (datePickerVal.setHours(0, 0, 0, 0) < todaysDate.setHours(0, 0, 0, 0)) {
            $(".action-header,action-col").hide();
        }

        // -- get appointments by clinic id --
        request_appointments($(this).data("value"));
    });





    // << ====================== Functions Declaration ====================== >>

    // --- this function is to get the menu item that should be active and highlight it ---
    function highlightNavItem() {
        var navURL = window.location.href.toLowerCase();
        var allNavElements = $("ul.sidebar-menu li a");
        var activeListItem;
        if (navURL.indexOf("dashboard") != -1) {
            $("#dashboard_nav_elem").addClass("active dashboard");
        } else {
            $(allNavElements).each(function() {
                activeListItem = $(this).find('span').text().toLowerCase();
                $(this).parent().removeClass();
                if (navURL.indexOf(activeListItem) != -1) {
                    $(this).parent().addClass("active");
                    $(this).parent().addClass(activeListItem);
                }
            });
        }

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
