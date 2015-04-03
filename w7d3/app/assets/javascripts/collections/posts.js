JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",

  model: JournalApp.Models.Post,

  getOrFetch: function (id) {
    var posts = this;
    var newPost;

    if (newPost = this.get(id)) {
      newPost.fetch();
    } else {
      newPost = new JournalApp.Models.Post({
        id: id
      });
      newPost.fetch({
        success: function () {
          posts.add(newPost);
        }
      });
    }

    return newPost;
  }

});
