TrelloClone.Views.BoardShow = Backbone.View.extend({
  template: JST['boardShow'],
  className: 'board',

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.lists(), 'sync', this.render);
  },

  render: function () {
    var content = this.template({
      board: this.model,
      lists: this.collection
    });
    this.$el.html(content);
    return this;
  },

});
