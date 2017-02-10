$(document).ready(function(){
    $('.star-cb-group label').on("click", function(){
        $('.star-cb-group input').attr('checked', false);
        $(this).prev().attr('checked', true)
    });
});
