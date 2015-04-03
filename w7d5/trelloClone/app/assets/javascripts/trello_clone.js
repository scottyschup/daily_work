window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function() {
    var $rootEl = $("#main");
    var boards = new TrelloClone.Collections.Boards();
    boards.fetch();

    new TrelloClone.Routers.Router(boards, $rootEl);
    Backbone.history.start();
  },

};

$(document).ready(function(){
  TrelloClone.initialize();
});
