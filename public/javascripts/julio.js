$( document ).ready( function () {
  $.backstretch( "/images/background.jpg", { speed: 500 }, function () { zoombg( 1 ); } );
  $( window ).konami( hypnoToad );
});

function hypnoToad () {
  $( "div#backstretch" ).remove();
  $( "body" ).css({ "background" : "#FFF url( /images/hypnotoad.gif )" });
};

function floatbg (direction) {
  var background = $( "div#jq_ez_bg" ).children( "img" );
  old_top = parseInt( background.css( "top" ).replace( "px", "" ) );

  background.animate({
    "top" : old_top - direction * 60
  }, 6000, "easeInOutQuad", function () {
    floatbg( -direction );
  });
};

function zoombg (direction) {
  var background = $( "div#backstretch img" );
  old_top = parseInt( background.css( "top" ).replace( "px", "" ) );
  old_left = parseInt( background.css( "left" ).replace( "px", "" ) );

  new_width = background.width() * Math.pow( 2, direction );
  new_height = background.height() * Math.pow( 2, direction );

  // thanks @hugopeixoto for helping me get rid of the ifs :D
  new_top = old_top - direction * background.height() / ( 3 - direction );
  new_left = old_left - direction * background.width() / ( 3 - direction );

  background.animate({
    "width" : new_width,
    "height" : new_height,
    "top" : new_top,// - background.height() / 2,
    "left" : new_left// - background.width() / 2
  }, 20000, "easeInOutQuad", function () {
    zoombg( -direction );
  });
};
