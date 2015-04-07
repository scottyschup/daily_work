TrelloClone.Routers.Router = Backbone.Router.extend({
  initialize: function (boards, $rootEl) {
    this.collection = boards;
    this.$rootEl = $rootEl;
  },

  routes: {
    "": "index",
    "boards/:id": "show"
  },

  index: function () {
    var boardsIndexView = new TrelloClone.Views.Boards({
      collection: this.collection
    });
    this._swapView(boardsIndexView);
  },

  show: function (id) {
    var board = this.collection.getOrFetch(id);
    var boardShowView = new TrelloClone.Views.BoardShow({
      model: board
    });

    this._swapView(boardShowView);
  },

  _swapView: function (view) {
    this._currView && this._currView.remove();
    this._currView = view;
    this.$rootEl.html(view.render().$el);
  }
});
