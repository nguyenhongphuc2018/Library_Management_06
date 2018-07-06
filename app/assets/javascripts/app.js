$(document).on('turbolinks:load', function(){
  navStick();
  goToIdPage();
});

navStick = function() {
  $(window).scroll(function() {
    if ($(document).scrollTop() > 50) {
        $('nav').removeClass('navbar-custom');
        $('nav').addClass('affix');
    } else {
        $('nav').removeClass('affix');
        $('nav').addClass('navbar-custom');
    }
  });
}

goToIdPage = function(){
  $('.link-page').on('click', function(e){
    e.preventDefault();
    var position = $($(this).attr("href")).offset().top;
    $("body, html").animate({
      scrollTop: position
    }, 1000 );
  });
}
