$( document ).ready( function () {
  $.backstretch( "/images/background.jpg", { speed: 500 }, zoombg );
});

function floatbg (direction) {
  var background = $( "div#jq_ez_bg" ).children( "img" );
  old_top = parseInt( background.css( "top" ).replace( "px", "" ) );

  background.animate({
    "top" : old_top - direction * 60
  }, 6000, "easeInOutQuad", function () {
    floatbg( -direction );
  });
};

function zoombg () {
  var background = $( "div#backstretch img" );
  old_top = parseInt( background.css( "top" ).replace( "px", "" ) );
  old_left = parseInt( background.css( "left" ).replace( "px", "" ) );

  background.animate({
    "width" : background.width() * 2,
    "height" : background.height() * 2,
    "top" : old_top - background.height() / 2,
    "left" : old_left - background.width() / 2
  }, 40000, "linear", function () {
  });
};
