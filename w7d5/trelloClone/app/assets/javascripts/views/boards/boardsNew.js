TrelloClone.Views.NewBoard = Backbone.View.extend({
  template: JST['boards/new'],

  events: {
    "submit form": "newBoard",
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);

    return this;
  },

  newBoard: function (ev) {
    ev.preventDefault();

    var params = $(ev.currentTarget).serializeJSON();
    var newBoard = new TrelloClone.Models.Board(params);

    newBoard.save();
  },
});
