$(document).on('turbolinks:load', function(){
  difSortBook();
  sortBook();
  searchBook();
  filterCategoryBook();
  searchAutoComplete();
  linkSeachClick();
  $('.result-item').on('click', function(){
    console.log('hello world');
  })
});

var defaultData = {
  q: {
    s: 'name asc'
  }
}
var $data = defaultData;

difSortBook = function() {
  $('#dirSortBook').on('change', function() {
    $data.q.s = $('#sortBook').val() + ' ' + this.value;
    $data.search = $('#inputSearch').val();
    sendData($data);
  })
}

sortBook = function() {
  $('#sortBook').on('change', function() {
    $data.q.s = this.value + ' ' + $('#dirSortBook').val();
    $data.search =  $('#inputSearch').val();
    sendData($data);
  });
}

searchBook = function() {
  $('#btnSearch').on('click', function(e){
    $data.search = $('#inputSearch').val();
    if(window.location.pathname === '/books'){
      $data.q.s = $('#sortBook').val() + ' ' + $('#dirSortBook').val();
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
    type: "GET",
    url: "/books",
    dataType: 'script',
    data: data,
  }); 
}

searchAutoComplete = function() {
  var $input = $("[data-behavior='autocomplete']"); 
  $('body').click(()=>{
    $('#showAutocomplete').html('');
  });
  $input.on('input', function() {
    $('#showAutocomplete').html('');
    $.ajax({
      type: "GET",
      url: "/books/search-autocomplete",
      dataType: "json",
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
      $data.q.s = $('#sortBook').val() + ' ' + $('#dirSortBook').val();
    }
    sendData($data);
    event.preventDefault();
  });
}
