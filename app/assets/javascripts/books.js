var books = {
  init: function(){
    $('.star-cb-group label').click(this.reviewChecker);
    $('.input-link').click(this.quantitySwitcher)
  },
  reviewChecker: function(){
    $('.star-cb-group input').attr('checked', false);
    $(this).prev().attr('checked', true)
  },
  quantitySwitcher: function(){
    if (($(this).find('.fa-plus').length)) {
      $('#order_item_quantity').val( function(i, old_val) {
        var int_val = parseInt(old_val);
        return isNaN(int_val) ? 1 : ++int_val;
      });
    }else{
      $('#order_item_quantity').val( function(i, old_val) {
        var int_val = parseInt(old_val);
        return (isNaN(int_val) || int_val <= 1 ) ? 1 : --int_val;
      });
    }
  }
};

$(document).ready(function(){
  books.init();
});


