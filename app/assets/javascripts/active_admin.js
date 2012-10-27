//= require active_admin/base
//= require jquery
//= require jquery_ujs

$(function() {
//    Movie Filter Ajax Search
    $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;


    $("#q_search input").keyup(function() {
        $.get($("#q_search").attr("action"), $("#q_search").serialize(), function(data){
            $('table#movies').html($('table#movies',data));
        }, "html");
        return false;
    });
});