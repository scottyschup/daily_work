TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST['cards/show'],
  className: "card",

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({
      card: this.model
    });
    this.$el.html(content);
    return this;
  }
});
