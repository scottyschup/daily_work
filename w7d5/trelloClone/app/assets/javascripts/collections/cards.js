TrelloClone.Collections.Cards = Backbone.Collection.extend({
  url: "api/cards",
  model: TrelloClone.Models.Card,

  comparator: function (model) {
    return -new Date(model.get('updated_at'));
  }
});
