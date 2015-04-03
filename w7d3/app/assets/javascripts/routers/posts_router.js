JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "": "insertPostsIndex",
    "posts/new": "newPost",
    "posts/:id": "displayPost",
    "posts/:id/edit": "editPost"
  },

  initialize: function($container, collection) {
    this.$container = $container;
    this.postsCollection = collection;
  },

  insertPostsIndex: function () {
    var postsIndexView = new JournalApp.Views.PostsIndex({
      collection: this.postsCollection
    });
    this.postsCollection.fetch();
    this.$container.html(postsIndexView.render().$el);
  },

  displayPost: function (id) {
    var post = this.postsCollection.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostShow({
      model: post,
      collection: this.postsCollection
    });
    this.$container.html(postShowView.render().$el);
  },

  editPost: function (id) {
    var post = this.postsCollection.getOrFetch(id);
    var editPostView = new JournalApp.Views.PostForm({
      model: post,
      collection: this.postsCollection
    });
    this.$container.html(editPostView.render().$el);
  },

  newPost: function () {
    var post = new JournalApp.Models.Post();
    var newPostView = new JournalApp.Views.PostForm({
      model: post,
      collection: this.postsCollection
    });
    this.$container.html(newPostView.render().$el);
  }

});
