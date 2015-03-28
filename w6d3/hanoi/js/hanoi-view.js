(function () {
  if (window.Hanoi === undefined) {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $canvas) {
    this.game = game;
    this.$canvas = $canvas;
    this.towers = game.towers;
    this.startTower = undefined;
    this.setUpTowers();
    this.clickHandler();
  };

  View.prototype.setUpTowers = function () {
    var stacks = "";
    for (var i = 0; i < 3; i++) {
      stacks += "<div class='tower tower" + i + "' data-col='"+ i +"'></div>";
    }
    this.$canvas.append(stacks);
    this.render();
  };

  View.prototype.render = function() {
    for (var i = 0; i < this.towers.length; i++) {
      var currTower = $('.tower' + i);
      var discs = "";
      for (var j = 0; j < this.towers[i].length; j ++) {
        discs += "<div class='disc disc" + this.towers[i][j] + "'></div>";
      }
      currTower.html(discs);
    }
  };

  View.prototype.clickHandler = function() {
    var that = this;
    $('.tower').on('click', function(event) {
      var thisClick = parseInt($(event.currentTarget).attr('data-col'));

      if (that.startTower === undefined) {
        that.startTower = thisClick;
      } else {
        if (that.game.move(that.startTower, thisClick)){
          that.render();
          that.startTower = undefined;
        } else {
          alert('Invalid Move');
          that.startTower = undefined;
        }
      }
    });
  };

})();
