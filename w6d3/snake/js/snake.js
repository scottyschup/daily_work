(function() {
  if (window.SnakeGame === undefined) {
    window.SnakeGame = {};
  }

  SnakeGame.DELTAS = {N: [-1, 0], E: [0, 1], S: [1, 0], W: [0, -1]};

  var Snake = SnakeGame.Snake = function(pos) {
    this.dir = 'E';
    this.segments = [new SnakeGame.Coord(pos)];
  };

  $.extend(Snake.prototype, {
    move: function() {
      var delta = SnakeGame.DELTAS[this.dir];
      var newHead = new SnakeGame.Coord(this.segments[0].plus(delta));
      var oldTail = this.segments.pop();
      this.segments.unshift(newHead);

      return [newHead, oldTail];
    },

    turn: function(newDir) {
      this.dir = newDir;
    }
  });

  var Board = SnakeGame.Board = function(startPos, boardLength) {
    this.snake = new Snake(startPos);
    this.boardLength = boardLength;
    this.grid = this.makeGrid();
  };

  $.extend(Board.prototype, {
    makeGrid: function() {
      var grid = [];
      for (var i = 0; i < this.boardLength; i++) {
        grid[i] = new Array(this.boardLength);
        for (var j = 0; j < this.boardLength; j++) {
          grid[i][j]= ".";
        }
      }
      return grid;
    },

    render: function() {
      for (var i = 0; i < this.snake.segments.length; i++) {
        var pos = this.snake.segments[i];
        this.grid[pos.coord[0]][pos.coord[1]] = "s";
      }

      return this.grid;
    }
  });

  var Coord = SnakeGame.Coord = function(coord) {
    this.coord = coord;
  };

  $.extend(Coord.prototype, {
    plus: function(otherCoord) {
      return [this.coord[0] + otherCoord[0],
              this.coord[1] + otherCoord[1]];
    },

    equals: function(otherCoord) {
      this.coord[0] === otherCoord[0] &&
          this.coord[1] === otherCoord[1];
    },

    isOpposite: function() {

    }
  });





})();
