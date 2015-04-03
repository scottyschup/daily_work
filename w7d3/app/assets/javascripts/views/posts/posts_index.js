JournalApp.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'],

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.collection.each( function (post) {
      var postItem = new JournalApp.Views.PostsIndexItem({ model: post });
      this.$('.posts-list').append(postItem.render().$el);
    }.bind(this));
    return this;
  },

  initialize: function () {
    this.listenTo(this.collection, "sync remove add change", this.render);
  }

});
