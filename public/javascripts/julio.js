$( document ).ready( function () {
	$( "body" ).ezBgResize({
		img : "/images/background.jpg"
	});

  setTimeout( function(){ floatbg(-1) }, 1000 );
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
