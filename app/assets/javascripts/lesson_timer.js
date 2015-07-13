total_times = $("#hidden-data").data("time-remaining");
time_over_msg = $("#hidden-data").data("time-over-msg");
$(document).ready(time_remaining(total_times));

function time_remaining(total_seconds){
  if(total_seconds <= 0){
    $("#time-remaining").text(time_over_msg);
    if(total_seconds == 0){
      $("form").submit();
    }
    $("[type='submit']").remove();
    return;
  }else{
    var minutes = Math.floor(total_seconds / 60);
    var seconds = total_seconds % 60;
    $("#time-remaining").text(minutes + " : " + seconds);
    setTimeout(function(){time_remaining(total_seconds - 1)}, 1000);
  }
}
