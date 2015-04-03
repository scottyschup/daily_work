JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['posts/post_form'],

  events: {
    "submit form": "updatePost"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({
      post: this.model,
      errors: this.errors
      });
    this.$el.html(content);
    return this;
  },

  updatePost: function (event) {
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON()['posts'];
    this.model.save(data, {
      success: function () {
        this.collection.add(this.model, { merge: true });
        Backbone.history.navigate('', { trigger: true });
      }.bind(this),

      error: function (model, errors) {
        this.errors = errors.responseJSON;
        this.render();
      }.bind(this)
    });
  }
});
