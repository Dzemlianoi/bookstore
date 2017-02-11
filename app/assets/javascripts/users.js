$(document).ready(function(){
    $( "#accept-delete" ).change(function() {
        $('.remove-btn').toggleClass('disabled');
    });
});
