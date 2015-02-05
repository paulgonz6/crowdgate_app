// VENDOR

//= require jquery
//= require jquery_ujs
//= require turbolinks

//  LIB
//= require behavior


// APP
//= require_tree .

function setupNavColorForTeam() {
  if ($.behavior("color-for-nav") != undefined) {
    var color = $.behavior("color-for-nav").val(),
        $nav = $('.navbar-default');
    $nav.css({"background-color":  color});
  }
}

function setupTransparentHeaderWhenSplash() {
  var $splash = $.behavior("splash"),
      $nav = $('.navbar-default');

  if ($splash.length == 0 || $splash == undefined) {
    $nav.removeClass('transparent');
  } else {
    $nav.addClass("transparent");

    var splashbottom = $splash.offset().top + $splash.height() - 100;

    $(window).on('scroll',function(){
      stop = Math.round($(window).scrollTop());

      if (stop > splashbottom) {
        if ($nav.hasClass("transparent")) {
          $nav.removeClass("transparent");
          $nav.css({"transition": "1s"});
        }
      } else {
        if (!$nav.hasClass("transparent")) {
          $nav.addClass("transparent");
          $nav.css({"transition": "0s"});
        }
      }
    });
  }
}

$(document).on("ready page:load fragment:load", function() {
  setupNavColorForTeam();
  setupTransparentHeaderWhenSplash();
});




  // on scroll,
