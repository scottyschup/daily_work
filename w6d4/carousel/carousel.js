$.Carousel = function (el) {
  this.$el = $(el);
  this.$items = $('.items');
  this.$images = $('.items').children();
  this.activate(0);
  this.setupClickHandlers();
};

$.extend($.Carousel.prototype, {
  activate: function (idx) {
    this.findImg(idx).addClass('active');
    this.activeIdx = idx;
  },

  deactivate: function (idx) {
    this.findImg(idx).removeClass('active');
  },

  removeDirs: function (idx) {
    this.findImg(idx).removeClass('left').removeClass('right');
  },

  setupClickHandlers: function() {
    var that = this;
    $('.slide-right').on('click', function(ev) {
      that.slide(-1);
    });

    $('.slide-left').on('click', function(ev) {
      that.slide(1);
    });
  },

  slide: function(dir) {
    if (this.transitioning){
      return;
    }
    var that = this;
    var oldIdx = this.activeIdx;
    var oldImg = this.findImg(oldIdx);
    var newIdx = (oldIdx + this.$images.length + dir ) % this.$images.length;
    var newImg = this.findImg(newIdx);
    oldImg.addClass(dir === 1 ? "left" : "right" );
    newImg.addClass(dir === -1 ? "left" : "right" );

    this.activate(newIdx);
    this.transitioning = true;
    setTimeout(function() {
      that.removeDirs(newIdx);
    }, 0);

    oldImg.one('transitionend', function(ev) {
      that.deactivate(oldIdx);
      that.removeDirs(oldIdx);
      that.transitioning = false;
    });
  },

  findImg: function (idx) {
    return this.$items.children().eq(idx);
  }
});

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
