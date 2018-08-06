// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap
//= require cocoon
//= require bootstrap-table
//= require_tree .

$.ajaxSetup({
    headers:
        { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
});

$(function() {
    $(".icon-button").hide();
    $(".icon").each(function (index) {
        $(this).click(function () {
            var iconGroup = $(this).parent();
            iconGroup.find('.icon-button').hide();
            var value = iconGroup.find("#value").text($(this).attr('id'));
            iconGroup.children().each(function () {
                $(this).css('border', '');
            });
            $(this).css('border', 'solid #0044cc');
            $(this).children('.icon-button').show();
        });
    });

    $(".icon-button").each(function () {
        $(this).click(function (e) {
            e.stopPropagation();
            var iconGroup = $(this).parents().find('.icon-group');
            $(this).parents().find('.icon').css('border', '');
            iconGroup.find("#value").text('');
            $(this).hide();
        });
    });
});