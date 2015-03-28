(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $('.canvas').on("click", '.square', function(event) {
      that.makeMove($(event.currentTarget));
    });
  };

  View.prototype.makeMove = function ($square) {
    if ($square.html() === "") {
      var pos = $square.attr('data-pos').split(',');
      this.game.playMove(pos);
      $square.html(this.game.currentPlayer);
      $square.addClass(this.game.currentPlayer);
      if (this.game.isOver()) {
        $('.canvas').off("click");
        $('.message').html(this.game.currentPlayer + ' wins!');
      }
    } else {
      alert("Invalid move!");
    }
  };

  View.prototype.setupBoard = function () {
    var squares = "";
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        squares += "<div class='square' data-pos='"+ i +","+ j +"'></div>";
      }
    }
    this.$el.append(squares);
  };
})();
