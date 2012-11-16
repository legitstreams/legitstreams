// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//=require bootstrap
//= require_tree .

$(function() {
//    Select box ajax search
    $.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;


    $("#movies_search select").change(function() {
        $.get($("#movies_search").attr("action"), $("#movies_search").serialize(), function(data){
            $('#movies').html(data);
        }, "html");
        _gaq.push(['_trackEvent', 'Search Actions', ($("#movies_search").attr("action"))]);
        return false;
    });

    $("#movies_search").submit(function(){
        $.get(this.action,$(this).serialize(),null,"script");
        return false;
    });


    if ($('.pagination').length){
      $(window).scroll (function(){
        url = $('.pagination .next_page').attr('href')
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50)
        {$('.pagination').text("Loading More Movies...")
          $.get(url, function(data){
                                  $('#movies').append(data);
                                },"html")
          $('.pagination').first().remove();
          $(window).scroll()
          _gaq.push(['_trackEvent', 'Scroll Links', url]);
        }

      });
    };


    $('.outbound_links').click(function() {
      _gaq.push(['_trackEvent', 'Outbound Links', this.href]);
    });




// Select Box Styling ... This needs to change to a better select box.

    if (!$.browser.opera) {

           $('select.select').each(function(){
               var title = $(this).attr('title');
               if( $('option:selected', this).val() != ''  ) title = $('option:selected',this).text();
               $(this)
                   .css({'z-index':10,'opacity':0,'-khtml-appearance':'none'})
                   .after('<span class="select">' + title + '</span>')
                   .change(function(){
                       val = $('option:selected',this).text();
                       $(this).next().text(val);
                       })
           });

       };




});
