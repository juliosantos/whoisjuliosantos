$( document ).ready( function() {

	$( "a.modal" ).fancybox({
    transitionIn : "elastic",
    transitionOut : "elastic",
    titlePosition : "inside"
  });

  $( "a.modal" ).tipTip({
    edgeOffset : 0,
    defaultPosition : "top",
    delay : 50
  });

});
