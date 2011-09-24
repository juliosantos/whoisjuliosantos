$( document ).ready( function () {
  $.backstretch( "/img/background.jpg", {speed: 500}, function () { whoIsJulioSantos.zoombg( 1 ); } );
});

var whoIsJulioSantos = (function () {
  var zoombg = function (direction) {
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
      "top" : new_top,
      "left" : new_left
    }, 20000, "easeInOutQuad", function () {
      zoombg( -direction );
    });
  };

  return {
    zoombg : zoombg
  }
})();
