var Board = function () {
  this.grid = []
  for (var i = 0; i < 3; i++) {
    this.grid.push([]);
    for (var j = 0; j < 3; j++) {
      this.grid[i].push(' ');
    }
  }
}

Board.prototype.print = function () {
  var printableBoard = this.grid.slice().reverse();
  for (var i = 0; i < 3; i++) {
    console.log(printableBoard[i]);
  }
}

module.exports = Board
