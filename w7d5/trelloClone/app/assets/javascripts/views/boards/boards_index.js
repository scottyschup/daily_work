TrelloClone.Views.Boards = Backbone.View.extend({
  template: JST['boards'],
  className: "boards-container",

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ boards: this.collection });
    this.$el.html(content);
    return this;
  }

});
