TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloClone.Models.Board,

  comparator: function (model) {
    return -new Date(model.get('updated_at'));
  },

  getOrFetch: function (id) {
    var board = this.get(id);

    if (!board) {
      board = new TrelloClone.Models.Board({ id: id });
      board.fetch({
        success: function () {
          this.add(board);
        }.bind(this)
      });
    } else {
      board.fetch();
    }

    return board;
  }

});
