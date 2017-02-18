$(document).ready(function() {
    $('.switchers').click(function () {
        var purchase_id = $(this).closest('tr').find('.purchase-id').val();
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
            url: '/order_item',
            contentType: 'application/json',
            data: JSON.stringify(
                {id: purchase_id, quantity: quantity_input.val() }
            ),
            success: function(response){
                if (response.status == 'updated'){
                    $(this).closest('tr')
                        .find('.position-price')
                        .text('€' + response.position_price);
                    $('.total-price').text('€' + response.total_price);
                    $('.subtotal').text('€' + response.total_price)
                }
            }
        });
    });
});
