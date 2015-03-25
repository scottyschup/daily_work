var Board = require('./board');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var Game = function(rdr) {
  this.rdr = rdr;
  this.board = new Board;
};

Game.prototype.closeReader = function () {
  this.rdr.close();
}

Game.prototype.getMove = function (callback) {
  this.rdr.question("Select your column\n", function(column) {
    this.rdr.question("Select your row\n", function(roww){
      var col = column;
      var row = roww;
      callback(col, row);
    });
  }.bind(this));
};

Game.prototype.isValidMove = function (col, row) {
  if (this.board.grid[row][col] === ' ') {
    return true;
  } else {
    return false;
  }
};

Game.prototype.move = function (col, row, sym) {
  if (this.isValidMove(col, row)) {
    this.board.grid[row][col] = sym;
    newSym = this.flipSymbol(sym);
  } else {
    console.log("Invalid move");
  }
};

Game.prototype.isWon = function () {
  var b = this.board.grid;

  if ((b[0][0] === b[1][1] && b[1][1] === b[2][2]) ||
    (b[0][2] === b[1][1] && b[1][1] === b[2][0])) {
    var same = true;
    var sym = b[1][1];
  } else {
    for (var i = 0; i < 3; i++) {
      if (b[i][0] === b[i][1] && b[i][1] === b[i][2]) {
        var same = true;
        var sym = b[i][0];
      } else if (b[0][i] === b[1][i] && b[1][i] === b[2][i]) {
        var same = true;
        var sym = b[0][i];
      }
    }
  }
  if (same && sym !== ' ') {
    this.board.print()
    console.log(sym + " won the game!");
    return true;
  } else {
    return false;
  }
}

Game.prototype.flipSymbol = function (sym) {
  if (sym === 'x') {
    sym = 'o';
  } else {
    sym = 'x';
  }

  return sym;
}

Game.prototype.run = function (sym, completionCallback) {
  this.board.print();
  this.getMove(function (col, row) {
    this.move(col, row, sym);

    if (!this.isWon()) {
      this.run(newSym, completionCallback);
    } else {
      completionCallback();
    }
  }.bind(this));
};

var ttt = new Game(reader);
ttt.run('x', function () {
  ttt.closeReader();
});
