window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
    new NewsReader.Routers.Router({
      "$rootEl": $("#content"),
      collection: new NewsReader.Collections.Feeds()
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
