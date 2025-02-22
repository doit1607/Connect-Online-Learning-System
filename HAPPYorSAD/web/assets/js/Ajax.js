/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

$(document).ready(function () {
    // Khi chọn một ngày
    $(document).on('click', '.available-tab ul.nav a', function (e) {
        e.preventDefault();
        let selectedDay = $(this).attr('href').split('=')[2];

        $.ajax({
            url: 'Slot',
            type: 'GET',
            data: {scheduleId: '${scheduleId}', day: selectedDay},
            success: function (response) {
                $('.tab-content.pt-0').fadeOut(200, function () {
                    $('.tab-content.pt-0').html($(response).find('.tab-content.pt-0').html()).fadeIn(200);
                });
            }

        });
    });

    // Xử lý thêm slot mà không cần load lại trang
    $(document).on('submit', 'form[action="Slot?action=add"]', function (e) {
        e.preventDefault();
        let formData = $(this).serialize();

        $.ajax({
            url: 'Slot?action=add',
            type: 'POST',
            data: formData,
            success: function (response) {
                $('.tab-content.pt-0').fadeOut(200, function () {
                    $('.tab-content.pt-0').html($(response).find('.tab-content.pt-0').html()).fadeIn(200);
                });
            }

        });
    });

    // Xử lý xóa tất cả slots
    $(document).on('submit', 'form[action="Slot?action=delete"]', function (e) {
        e.preventDefault();
        if (!confirm('Are you sure you want to delete all slots?'))
            return;
        let formData = $(this).serialize();

        $.ajax({
            url: 'Slot?action=delete',
            type: 'POST',
            data: formData,
            success: function (response) {
                $('.tab-content.pt-0').fadeOut(200, function () {
                    $('.tab-content.pt-0').html($(response).find('.tab-content.pt-0').html()).fadeIn(200);
                });
            }

        });
    });
});
