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
    this.$rootEl.empty().html(boardsIndexView.render().$el);
  },

  show: function (id) {
    var board = this.collection.getOrFetch(id);
    var boardShowView = new TrelloClone.Views.BoardShow({
      model: board
    });

    this.$rootEl.empty().html(boardShowView.render().$el);
  }
});
