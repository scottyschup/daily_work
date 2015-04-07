TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  template: JST['lists/show'],
  className: "list",

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.cards(), 'add', this.addCardView);
    this.model.cards().each(this.addCardView.bind(this));
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  addCardView: function (card) {
    var cardShowView = new TrelloClone.Views.CardShow({
      model: card
    });
    this.addSubview('.cards', cardShowView);
  }
});
