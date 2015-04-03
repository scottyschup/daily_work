NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
    this.collection.fetch();
  },

  routes: {
    "" : "index",
    "feeds/:id": "show"
  },

  index: function(){
    this.collection.fetch();
    var view = new NewsReader.Views.FeedIndex({
      collection: this.collection
    });
    this.$rootEl.html(view.render().$el);
  },

  show: function (id) {
    var feed = new this.collection.model({id: id});
    feed.fetch();
    var feedShow = new NewsReader.Views.FeedShow({
      model: feed
    });
    this.$rootEl.html(feedShow.render().$el);
  }
});
