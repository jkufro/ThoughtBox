// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery-ui
//= require popper
//= require bootstrap-sprockets
//= require_tree .

var request_delay = 5000; // ms
var color_changing_element = "html, #thought-div"
var positive_color = "rgba(65, 187, 64, 0.8)";
var netutral_color = "rgba(211, 212, 157, 0.8)";
var negative_color = "rgba(197, 44, 44, 0.8)";
var transition_time = 3000  // ms
var thought_text_id = "#thought"
var reactive_element = "#thought-div"
var is_finger_on_screen = false;


function run_ajax(method, data, url, success_callback=function(res){}, failure_callback=function(res){}){
  $.ajax({
    method: method,
    data: data,
    url: url,
    success: function(res) {
      success_callback(res);
    },
    error: function(res) {
      console.log("error");
      failure_callback(res);
    }
  })
}


function change_text(text) {
  $(thought_text_id).fadeOut(transition_time / 2, function() {
    $(thought_text_id).text(text);
  });

  $(thought_text_id).fadeIn(transition_time / 2);
}


function get_thought() {
  run_ajax('GET',
           {},
           '/thought',
           function(res) { get_thought_success(res) },
           function(res) { get_thought_failure(res) }
          );
}


function get_thought_success(res) {
  change_text(res.content)
  if (res.mood == 'positive') {
    $(color_changing_element).animate({backgroundColor: positive_color}, 3000);
  } else if (res.mood == 'negative') {
    $(color_changing_element).animate({backgroundColor: negative_color}, 3000);
  } else {
    $(color_changing_element).animate({backgroundColor: netutral_color}, 3000);
  }
}


function get_thought_failure(res) {
  console.log(res);
  set_to_thought_default();
}


function set_to_thought_default() {
  change_text("Place Finger on Cloud")
  $(color_changing_element).animate({backgroundColor: netutral_color}, 3000);
}


$( document ).ready(function () {
  $(reactive_element).on('mousedown touchstart',function(e){
    is_finger_on_screen = true;
  });
  $(reactive_element).on('mouseup touchend',function(e){
    is_finger_on_screen = false;
  });

  setInterval(
    function() {
      if (is_finger_on_screen) {
        get_thought();
      } else {
        set_to_thought_default()
      }
    }, request_delay
  );
});
