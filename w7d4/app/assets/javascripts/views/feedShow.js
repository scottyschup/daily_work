NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feedShow'],

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.refresh": "render"
  },

  render: function() {
    var content = this.template({
      entries: this.model.entries(),
      title: this.model.escape('title')
    });
    this.$el.html(content);
    return this;
  }
});
