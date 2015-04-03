TrelloClone.Models.Board = Backbone.Model.extend({
  urlRoot: "api/boards",

  lists: function () {
    if (!this._entries) {
      this._entries = new TrelloClone.Collections.Lists([], { board: this });
    }

    return this._entries;
  }
});
