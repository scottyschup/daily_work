NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  url: function () {
    return this.feed.url() + '/entries'
  },
  comparator: function (model) {
    return -new Date(model.get('published_at'))  
  }
});
