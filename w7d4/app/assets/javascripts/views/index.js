NewsReader.Views.FeedIndex = Backbone.View.extend({
  tagName: 'ul',

  template: JST['index'],

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function(){
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);
    return this;
  }
});
