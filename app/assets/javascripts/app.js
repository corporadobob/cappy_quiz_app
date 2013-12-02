$(function(){
  $('#click-me').on('click', function(){
    $('#java-title').html('Jabba Jive');
    $('body').addClass('pink');
    $(this).attr('disabled', true);
  });

  $('#calc').on('click', function(){
    var nums = $('#numbers').val();
    check_increasing(nums);
  });
});

function check_increasing(numbers){
  var original = numbers.split(',');
  var sorted = numbers.split(',').sort();

  var check = arraysSame(original, sorted);

  if(check) {
    $('body').addClass('green');
  } else {
    $('body').addClass('red');
  }
}

function arraysSame(arr1, arr2) {
  if(arr1.length !== arr2.length)
    return false;
  for(var i = arr1.length; i--;) {
    if(arr1[i] !== arr2[i])
      return false;
  }
  return true;
}
