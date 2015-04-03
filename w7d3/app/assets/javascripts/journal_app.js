window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(sidebar, $content) {
    var postsCollection = new JournalApp.Collections.Posts();
    postsCollection.fetch();
    var postsIndexSidebar = new JournalApp.Views.PostsIndex({
      collection: postsCollection
    });
    sidebar.html(postsIndexSidebar.render().$el);
    new JournalApp.Routers.PostsRouter($content, postsCollection);
    Backbone.history.start();

  }
};

$(document).ready(function(){
  var $sidebar = $('.sidebar');
  var $content = $('.content');
  JournalApp.initialize($sidebar, $content);
});
