$(document).ready(function(){
    $('.star-cb-group label').on("click", function(){
        $('.star-cb-group input').attr('checked', false);
        $(this).prev().attr('checked', true)
    });

    $('.input-link').on('click', function(){
        if (($(this).find('.fa-plus').length)) {
            $('#book_quantity').val( function(i, oldval) {
                var int_val = parseInt(oldval);
                return isNaN(int_val) ? 1 : ++int_val;
            });
        }else{
            $('#book_quantity').val( function(i, oldval) {
                var int_val = parseInt(oldval);
                return (isNaN(int_val) || int_val <= 1 ) ? 1 : --int_val;
            });
        }
    })
});
