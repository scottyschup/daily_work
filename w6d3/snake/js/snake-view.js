(function() {
  if (window.SnakeGame === undefined) {
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function($el) {
    this.$el = $el;
    this.board = new SnakeGame.Board([1,1], 40);
    this.keyHandler();
    this.setupBoard();
    var that = this;
    setInterval(function(){
      that.renderMove();
    }, 500);
  };

  $.extend(View.prototype, {
    keyHandler: function() {
      var that = this;
      $(window).on('keydown', function(ev) {
        that.handleKeyEvent(ev);
      });
    },

    renderMove: function () {
      var coords = this.board.snake.move();
      var newHead = coords[0].coord;
      var oldTail = coords[1].coord;
      $('.square[data-coord="' + oldTail[0] + ',' + oldTail[1] + '"]')
        .removeClass("snake");
      $('.square[data-coord="' + newHead[0] + ',' + newHead[1] + '"]')
        .addClass("snake");
    },

    handleKeyEvent: function(ev) {
      var char = ev.keyCode;
      if (char === 37) {
        this.board.snake.turn("W");
      } else if (char === 38) {
        this.board.snake.turn("N");
      } else if (char === 39) {
        this.board.snake.turn("E");
      } else if (char === 40) {
        this.board.snake.turn("S");
      } else {
        // alert("Use arrow keys!");
      }
    },

    setupBoard: function() {
      var squares = "";
      for (var i = 0; i < this.board.boardLength; i++) {
        for (var j = 0; j < this.board.boardLength; j++) {
          squares += "<div class='square' data-coord='"+ i +","+ j +"'></div>";
        }
      }
      this.$el.append(squares);
      this.placeSnake();
    },

    placeSnake: function() {
      for (var i = 0; i < this.board.snake.segments.length; i++) {
        var pos = this.board.snake.segments[i].coord;
        var dataCoord = '[data-coord="' + pos[0] + ',' + pos[1] + '"]';
        var snakeSquare = $('.square' + dataCoord);
        snakeSquare.addClass('snake');
      }
    }
  });
})();
