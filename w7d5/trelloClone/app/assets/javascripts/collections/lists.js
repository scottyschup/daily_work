TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: "api/lists",
  model: TrelloClone.Models.Card,

  comparator: function (model) {
    return -new Date(model.get('updated_at'));
  }
});
