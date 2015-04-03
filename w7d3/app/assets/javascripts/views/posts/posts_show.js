JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  className: "post-show",

  events: {
    "dblclick p": "renderEdit",
    "blur input": "endEditing",
    "blur textarea": "endEditing"
  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);

    return this;
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  renderEdit: function (event) {
    var $currentTarget = $(event.currentTarget);
    var attr = $currentTarget.data("attr");
    var val = $currentTarget.html();

    var $input;
    if (attr === "title") {
      $input = $('<input type="text">').val(val);
    } else {
      $input = $('<textarea>').html(val);
    }

    $input.data('attr', attr);

    this._swapView($currentTarget, $input);
  },

  _swapView: function($old, $new) {
    $old.replaceWith($new);
    $new.focus();
  },

  endEditing: function (event) {
    var $currentTarget = $(event.currentTarget);
    var data = $currentTarget.val();
    var attr = $currentTarget.data('attr');
    var params = {};
    params[attr] = data;
    var $p = $('<p>').html(data).data('attr', attr);

    this.model.save(params, {
      success: function () {
        this.collection.add(this.model, { merge: true });
        this._swapView($currentTarget, $p);
      }.bind(this),

      error: function (model, errors) {
        this.errors = errors.responseJSON;
        this.render();
      }.bind(this)
    });
  }

});
