$(function(){
  $('#click-me').on('click', function(){
    $('#java-title').html('Jabba Jive');
    $('body').addClass('pink');
    $(this).attr('disabled', true);
  });
});
