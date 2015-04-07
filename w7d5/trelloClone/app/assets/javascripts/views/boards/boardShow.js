TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST['boards/show'],
  className: 'board-show',

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.lists(), 'add', this.addListView);
    this.model.lists().each(this.addListView.bind(this)); // in case we've alreay added lists
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  addListView: function (list) {
    var listShowView = new TrelloClone.Views.ListShow({
      model: list
    });
    this.addSubview('.lists', listShowView);
  }
});
