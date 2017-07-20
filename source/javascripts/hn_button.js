$.fn.hnButton = function() {
  // this is the button to be upgraded
  var linkbutton = this;

  // bypass Algolia if we know the Hacker News discussion URL
  if (linkbutton.data('override')) {
    return linkbutton;
  }

  var title = document.title;
  var thisUrl = window.location.href;
  if (linkbutton.data('title')) {
    title = linkbutton.data('title');
  }
  var hnUrlPrefix = "https://news.ycombinator.com/item?id=";

  // default button action
  linkbutton.click(function(evt){
    evt.preventDefault();
    window.open('http://news.ycombinator.com/submitlink?u='+encodeURIComponent(thisUrl)+'&t='+encodeURIComponent(title));
  });

  if (linkbutton.length) {
    var api = 'https://hn.algolia.com/api/v1/search';
    var params = {
      tags: 'story',
      query: thisUrl,
      restrictSearchableAttributes: 'url',
      advancedSyntax: true
    };
    $.getJSON(api, params, function(data){
      if (data.nbHits > 0) {
        $.each(data.hits, function(index, item){
          if (item.url === thisUrl) {
            // this is our item!
            var hnPostLink = hnUrlPrefix + item.objectID;
            linkbutton.unbind('click');
            linkbutton.attr('href', hnPostLink);
            return;
          }
        });
      }
    });
  }
  return linkbutton;
};
