$.Thumbnail = function (el) {
  this.$el = $(el);
  this.$images = $('.gutter-images').children();
  this.$currentGutter = $(this.$images.slice(0, 5));
  this.gutterStartIdx = 0;
  this.$gutter = $('.gutter-images');
  this.$active = $(".active");
  this.activate(this.$images.first());
  this.setActiveImg(this.$images.first());
  this.renderGutter();
  this.setUpHandlers();
};

$.extend($.Thumbnail.prototype, {
  activate: function(image){
    var $newImage = $(image).clone();
    this.$active.html($newImage);
    $newImage.addClass("active");
  },

  setActiveImg: function(image){
    this.$activeImg = $(image);
  },

  setUpHandlers: function(){
    var that = this;
    this.$gutter.on('click', 'img', function(ev){
      that.activate(ev.currentTarget);
      that.setActiveImg(ev.currentTarget);
    });
    this.$gutter.on('mouseenter', 'img', function(ev){
      that.activate(ev.currentTarget);
    });
    this.$gutter.on('mouseleave', 'img', function(ev) {
      that.activate(that.$activeImg);
    });
    this.$el.on('click', 'a', function(ev) {
      if ($(ev.currentTarget).attr("class") === "nav left") {
        that.shiftGutter(-1);
      } else {
        that.shiftGutter(1);
      }
    });
  },

  shiftGutter: function (dir) {
  //   if (dir === -1) {
  //     // unshift
  //     if (this.gutterStartIdx === 0) {
  //       this.$currentGutter.unshift(this.$images.last());
  //       this.gutterStartIdx = this.$images.length - 1;
  //     } else {
  //       this.$currentGutter.unshift(this.$images.eq(this.gutterStartIdx - 1));
  //       this.gutterStartIdx--;
  //     }
  //     // pop
  //     this.$currentGutter.splice(0, this.$images.length - 1);
  //   } else {
  //     if (this.gutterStartIdx + 5 === this.$images.length) {
  //       this.$currentGutter.push(this.$images.first());
  //       this.gutterStartIdx++;
  //     } else {
  //       this.$currentGutter.push(this.$images.eq(this.gutterStartIdx + 5));
  //       this.gutterStartIdx = (this.gutterStartIdx + 1) % this.$images.length;
  //     }
  //     this.$currentGutter.splice(1);
  //   }
    if ((this.gutterStartIdx === 0 && dir === -1) ||
        (this.gutterStartIdx === this.$images.length - 5 && dir === 1)) {
      return;
    } else {
      this.gutterStartIdx += dir;
    }
    this.renderGutter();
  },

  renderGutter: function() {
    $(".visible").removeClass("visible");
    var start = this.gutterStartIdx;

    this.$currentGutter = $(this.$images.slice(start, start + 5));
    this.$currentGutter.each(function(idx){
      $(this).addClass("visible");
    });
  },
});

$.fn.thumbnail = function () {
  return this.each(function () {
    new $.Thumbnail(this);
  });
};
