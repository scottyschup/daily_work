TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloClone.Models.Board,

  comparator: function (model) {
    return -new Date(model.get('updated_at'));
  }

});
