$(document).on('turbolinks:load', function(){
  sortBook();
  searchBook();
  filterCategoryBook();
  searchAutoComplete();
  linkSeachClick();
  advancedSearchClick();
});

var defaultData = {
  q: {
    s: 'name asc'
  }
}
var $data = defaultData;

sortBook = function() {
  $('#sortBook').on('change', function() {
    $data.q.s = this.value;
    $data.search =  $('#inputSearch').val();
    sendData($data);
  });
}

searchBook = function() {
  $('#btnSearch').on('click', function(e){
    $data.search = $('#inputSearch').val();
    if(window.location.pathname === '/books'){
      $data.q.s = $('#sortBook').val();
    }
    sendData($data);
    e.preventDefault();
  });
}

filterCategoryBook = function() {
  $data.categories = [];
  $(document).on('click', '#filteCategory .ckcategory', function() {
    $data.q.categories_id_in = $('#filteCategory input:checked').map(function() {
     return $(this).val()
    }).get();
    sendData($data);
  })
}

sendData = function(data) {
  $.ajax({
    type: 'GET',
    url: '/books',
    dataType: 'script',
    data: data,
  }); 
}

searchAutoComplete = function() {
  var $input = $('[data-behavior=\'autocomplete\']'); 
  $('body').click(function(){
    $('#showAutocomplete').html('');
  });
  $input.on('input', function() {
    $('#showAutocomplete').html('');
    $.ajax({
      type: 'GET',
      url: '/books/search/autocomplete',
      dataType: 'json',
      data: {q: $(this).val()},
      success: function(data){
        if(data.search)
          data.search.forEach(function(e){
            $('#showAutocomplete').append('<a href=\'#\' class=\'result-link\' data-link=\''+e.name+
            '\'><li class=\'result-item\'>'+e.name+'</li></a>')
          });
      }
    })
  })
}

linkSeachClick = function () {
  $(document).on('click', '.result-link', function(event) {
    $('#inputSearch').val($(this).data('link'))
    $data.search = $(this).data('link');
    if(window.location.pathname === '/books'){
      $data.q.s = $('#sortBook').val();
    }
    sendData($data);
    event.preventDefault();
  });
}

advancedSearchClick = function() {
  $('#advancedSearch').on('click',function(event){
    var title = $('#advancedTitle').val();
    var author = $('#advancedAu').val();
    var publisher = $('#advancedPub').val()
    if(title){
      $data.q.name_cont = title;
    }
    if(author){
      $data.q.authors_name_cont = author;
    }
    if(publisher){
      $data.q.publishers_name_cont = publisher;
    }
    if(title || author || publisher){
      sendData($data);
    }
    event.preventDefault();
  })
}
