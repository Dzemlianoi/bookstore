$(document).ready(function() {
  $('.switchers').click(function () {
    var purchase_id = $(this).closest('.purchase').find('.purchase-id').val();
    var quantity_input = $(this).closest('.input-group').find('.quantity-input');
    var quantity = parseInt(quantity_input.val());
    quantity_input.val($(this).hasClass('fa-plus')
        ? ++quantity
        : quantity != 1
            ? --quantity
            : 1
     );
    $.ajax({
      context: this,
      type: "PUT",
      dataType: "json",
      url: "/order_items/" + purchase_id,
      contentType: 'application/json',
      data: JSON.stringify({
        order_item: {
          id: purchase_id,
          quantity: quantity_input.val()
        }
      }),
      success: function(response){
        if (response.status == 'updated'){
          $(this).closest('.purchase').find('.position-price').text('€' + response.position_price);
          $('.coupon').text('€' + response.discount);
          $('.total-price .pricable').text('€' + response.total_price);
          $('.items-total .pricable').text('€' + response.subtotal_price)
        }
      }
    });
  });
});
