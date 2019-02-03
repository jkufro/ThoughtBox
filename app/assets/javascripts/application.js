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
//= require popper
//= require bootstrap-sprockets
//= require_tree .


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


function get_thought() {
  run_ajax('GET',
           {},
           '/thought',
           function(res) { get_thought_success(res) },
           function(res) { get_thought_failure(res) }
          );
}

function get_thought_success(res) {
  $('#thought').text(res.content);
  if (res.mood == 'positive') {
    $('#thought-div').css("background", "green");
  } else if (res.mood == 'negative') {
    $('#thought-div').css("background", "red");
  } else {
    $('#thought-div').css("background", "white");
  }
}


function get_thought_failure(res) {
  console.log(res);
  $('#thought').text("Retrieving Thought...");
  $('#thought-div').css("background", "white");
}


$( document ).ready(function () {
  let request_delay = 5000; // ms
  setInterval(
    function() {
      get_thought();
    }, request_delay
  );
});
