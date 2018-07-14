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
  var dropdown = $('.navbar-right .dropdown-search');
  var toogleBtn = $('.navbar-right .dropdown-search-toggle');
  dropdown.on('show.bs.dropdown', function(e){
    toogleBtn.toggleClass('hide');
  });
  dropdown.on('hide.bs.dropdown', function(e){
    toogleBtn.addClass('hide');
    toogleBtn.first().removeClass('hide');
  });
}

// ratings book action
$(document).on('turbolinks:load',() => {
  $('.rating-star').on('click', function() {
    $(this).parents('.rating').find('.rating-star').removeClass('star-checked ');
    $(this).addClass('star-checked ');
        
    var book =  $(this).parents('.rating').data('book');
    var point = $(this).data('value');

    $.ajax({
      type: 'POST',
      url: '/rates',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      data: {rating:{point: point,
        book_id: book}},
    });
  });
});
