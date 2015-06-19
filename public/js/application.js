$(document).ready(function() {
  var $overlay = $('<div id="overlay"></div>');
  var $close = $("<p>Click to close</p>");
  var $image = $("<img>");
  var $caption = $("<p></p>");

  $close.css({'text-align': 'right',
              'margin-right': '20px',
              'font-size': '0.75em'});

  $overlay.append($close);

  $overlay.append($image);

  $("body").append($overlay);

  $overlay.append($caption);

  $(".image a").click(function(event){
    event.preventDefault();
    var imageLocation = $(this).attr("href");
    $image.attr("src", imageLocation);

    $overlay.show();

    var captionText = $(this).children("img").attr("alt");
    $caption.text(captionText);
  });

  $overlay.click(function() {
    $overlay.hide();
  });
});
