JournalApp.Views.PostsIndexItem = Backbone.View.extend({

  events: {
    "click .delete-post": "deletePost"
  },

  template: JST['posts/index_item'],

  tagName: 'li',

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
  }

});
