NewsReader.Models.Entry = Backbone.Model.extend({
  initialize: function(options){
    this.feed = options.feed;
  },

  urlRoot: function () {
    return this.feed.url() + '/entries'
  }
});
