TrelloClone.Models.Card = Backbone.Model.extend({
  urlRoot: "api/cards",

  lists: function () {
    if (!this._items) {
      this._items = new TrelloClone.Collections.Items([], { card: this });
    }

    return this._items;
  }
});
