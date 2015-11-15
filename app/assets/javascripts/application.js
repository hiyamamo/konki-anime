// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function onPushWatchBtn(e){
  var isWatching = $(e).hasClass("watching");

  var select = $(e).prev();

  var detailId = select.val();

  var userName = $(e).attr("data");


  var url = "/users/" + userName + "/watch_lists";

  if(isWatching){

    $.ajax({
      type: "DELETE",
      url: url + "/" + detailId,
      success: function(){
        onSuccessAjax(e);
        select.attr("disabled", false);
      },
    });

  }else{

    $.ajax({
      type: "POST",
      url: url,
      data: { detail_id: detailId },
      success: function(){
        onSuccessAjax(e);
        select.attr("disabled", "disabled");
      },
    });
  }

}

function onSuccessAjax(e){
  $("span", e).toggle();
  $(e).toggleClass("watching");
}


function ready() {
  $(".watch-button").hover(
      function() {
        $(".watched-text", this).html("解除");
      },
      function() {
        $(".watched-text", this).html("投票済み");
      });

};

$(document).ready(ready);
$(document).on('page:load', ready);
