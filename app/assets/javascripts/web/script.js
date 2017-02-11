$("document").ready(function() {

    // << ====================== Functions Calls ====================== >>
    highlightNavItem();
    styleConfirmModal();

    // -- datepicker for the appoinments page --
    //$("#app_date").datepicker().datepicker("setDate", new Date());
    $(".app_date").datepicker({
        dateFormat: 'yy-mm-dd'
    });
    $(".app_date").datepicker().datepicker('setDate', 'today');

    $('.table').DataTable({
        bFilter: false,
        bLengthChange: false,
        bSort: false,
        pageLength: 20,
        oLanguage: {
            "sEmptyTable": "No data available",
            "oPaginate": {
                "sNext": '&gt>',
                "sLast": '&raquo;>>',
                "sFirst": '&laquo;<<',
                "sPrevious": '&lt;<'
            },
            "sInfo": "_START_ - _END_ of _TOTAL_"
        }
    });

    $(".form").validate();

    // << ====================== Functions Declaration ====================== >>

    // --- this function is to get the menu item that should be active and highlight it ---
    function highlightNavItem() {
        var themeClasses = $("#main_content").attr("class");
        if (themeClasses) {
            themeClasses = themeClasses.split(' ');
            var themeColor;
            $.each(themeClasses, function(index, value) {
                if (value.indexOf("theme") != -1) {
                    themeColor = value.split('-');
                    themeColor = themeColor[0];
                }
            });
            $(".sidebar-menu .active").removeClass("active");
            switch (themeColor) {
                case "yellow":
                    $(".sidebar-menu .dashboard").addClass('active');
                    break;
                case "orange":
                    $(".sidebar-menu .hospitals").addClass('active');
                    break;
                case "green":
                    $(".sidebar-menu .clinics").addClass('active');
                    break;
                case "red":
                    $(".sidebar-menu .doctors").addClass('active');
                    break;
                case "blue":
                    $(".sidebar-menu .appointments").addClass('active');
                    break;
            }
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
