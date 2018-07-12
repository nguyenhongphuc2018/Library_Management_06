$(document).on('turbolinks:load', function(){
  difSortBook();
  sortBook();
  searchBook();
  filterCategoryBook();
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
