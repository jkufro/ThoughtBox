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

var color_changing_element = "html, #thought-div"
var positive_color = "rgba(65, 187, 64, 0.8)";
var netutral_color = "rgba(211, 212, 157, 0.8)";
var negative_color = "rgba(197, 44, 44, 0.8)";
var transition_time = 3000  // ms
var thought_text_id = "#thought"
var reactive_element = "#thought-div"
var fingers_on_screen = 0;
var default_text = "Press and Hold Cloud to Export Thought";
var failure_text = "Failed to Retrieve Thought";


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
  color = null;
  if (res.mood == 'positive') {
    color = positive_color;
  } else if (res.mood == 'negative') {
    color = negative_color;
  } else {
    color = netutral_color;
  }
  $(color_changing_element).animate({backgroundColor: color}, 3000);
}


function get_thought_failure(res) {
  console.log(res);
  set_to_thought_failed();
}


function set_to_thought_default() {
  change_text(default_text)
  $(color_changing_element).animate({backgroundColor: netutral_color}, 3000);
}


function set_to_thought_failed() {
  change_text(failure_text)
  $(color_changing_element).animate({backgroundColor: netutral_color}, 3000);
}


$( document ).ready(function () {
  $(reactive_element).on('mousedown touchstart',function(e){
    fingers_on_screen += 1;
    if (fingers_on_screen > 0 && $(thought_text_id).text() == default_text) {
      get_thought();
    }
  });
  $(reactive_element).on('mouseup touchend',function(e){
    fingers_on_screen -= 1;
    if (fingers_on_screen <= 0 && $(thought_text_id).text() != default_text) {
      set_to_thought_default();
    }
  });
});
