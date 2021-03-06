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
var default_text = "Press and Hold to Export";
var failure_text = "Failed to Export";

var progress_element = '#progress-bar'
var max_progess = 100;
var min_progress = 0;
var current_progress = min_progress;
var progress_speed = 1;
var scanning = false;
var playing = false;

var loading_text_element = "#loading-text";
var loading_texts = [{ text: "Reading body temperature", len: 15 },
                     { text: "Reading pulse", len: 10 },
                     { text: "Exporting brain waves", len: 20 },
                     { text:"Analyzing brain waves", len: 20 },
                     { text: "Cross referencing readings with database", len: 10},
                     { text: "Determining related thoughts", len: 10},
                     { text: "Running cleanup tasks", len: 10},
                     { text: "Export complete", len: 5}];
var current_loading_text_index = 0;
var current_loading_text_progress = 0;


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


function reset() {
  $(thought_text_id).fadeOut(transition_time / 2, function() {
    $(thought_text_id).text(default_text);
    $(thought_text_id).fadeIn(transition_time / 2, function() {
      playing = false;
      scanning = false;
    });
  });
}


function play_chain(chain, index, finished_callback=function(){}) {
  if (index >= chain.length) {
    finished_callback();
    return;
  }

  thought = chain[index]
  text = thought['content']

  $(thought_text_id).fadeOut(transition_time / 2, function() {
    $(thought_text_id).text(text);
    $(thought_text_id).fadeIn(transition_time / 2, function() {
      play_chain(chain, index + 1, finished_callback);
    });
  });
}


function get_chain_success(res) {
  play_chain(res, 0, finished_callback=reset);
}


function get_chain_failure(res) {
  failed_thought_chain = [{
    id: 1,
    content: failure_text,
    mood: "positive",
    next_thought_id: null,
    previous_thought_id: null,
    updated_at: "2019-02-11T00:32:31.551Z",
    created_at: "2019-02-11T00:32:31.547Z"
  }];
  play_chain(failed_thought_chain, 0, finished_callback=reset);
}


function get_and_play_chain() {
  run_ajax('GET',
           {},
           '/thought',
           function(res) { get_chain_success(res) },
           function(res) { get_chain_failure(res) }
          );
}


function is_progress_full() {
  return current_progress >= max_progess;
}


function increment_progress() {
  current_progress = Math.min(current_progress + progress_speed, max_progess);
}


function draw_progress() {
  $(progress_element).css({width: current_progress + '%'});
}


function increment_loading_text() {
  current_loading_text = loading_texts[current_loading_text_index]
  suffix = "";
  for (var i = 0; i <= current_loading_text_progress; i++) {
    suffix = suffix + '.';
  }
  if (current_loading_text['text'] == "Export complete") {
    suffix = "";
  }
  $(loading_text_element).text(current_loading_text['text'] + suffix);

  current_loading_text_progress += 1
  if (current_loading_text_progress >= current_loading_text['len']) {
    current_loading_text_index += 1;
    current_loading_text_progress = 0;
  }
  if (current_loading_text_index >= loading_texts.length) {
    current_loading_text_index = 0;
  }
}

function reset_loading_text() {
  $(loading_text_element).text("");
  current_loading_text_index = 0;
  current_loading_text_progress = 0;
}

$( document ).ready(function () {
  $(reactive_element).on('mousedown touchstart',function(e){
    if (!playing) {
      scanning = true;
      $(thought_text_id).text("");
    }
  });
  $(reactive_element).on('mouseup touchend',function(e){
    if (scanning) {
      scanning = false;
      current_progress = min_progress;
      draw_progress();
      reset_loading_text();
      $(thought_text_id).text(default_text);
    }
  });

  setInterval(function(){
    if (scanning) {
      increment_progress();
      increment_loading_text();
      draw_progress();

      if (is_progress_full()) {
        scanning = false;
        playing = true;
        current_progress = min_progress;
        draw_progress();
        reset_loading_text()
        get_and_play_chain();
      }
    }
  }, 100);
});
