$(document).on('turbolinks:load', function(){
  goToIdPage();
  searchBarIcon();
});

goToIdPage = function(){
  $('.link-page').on('click', function(e){
    e.preventDefault();
    if(window.location.pathname !== '/')
      window.location.replace('/'+ $(this).attr('href'));
    else {
      var position = $($(this).attr('href')).offset().top;
      $('body, html').animate({
        scrollTop: position
      }, 1000 );
    }
    
  });
}

searchBarIcon = function() {
  var dropdown = $('.navbar-right .dropdown');
  var toogleBtn = $('.navbar-right .dropdown-toggle');
  dropdown.on('show.bs.dropdown', function(e){
    toogleBtn.toggleClass('hide');
  });
  dropdown.on('hide.bs.dropdown', function(e){
    toogleBtn.addClass('hide');
    toogleBtn.first().removeClass('hide');
  });
}
