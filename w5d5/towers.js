var readline = require('readline');

var HanoiGame = function () {
  this.stacks = [[1, 2, 3], [], []];

  this.reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
};


HanoiGame.prototype.isWon = function () {
  if(this.stacks[1].length === 3 || this.stacks[2].length === 3) {
    return true
  } else {
    return false
  }
};

HanoiGame.prototype.isValidMove = function (start, end) {
  // var start = Number(start);
  // var end = Number(end);

  if(this.stacks[start] === []) {
    return false;
  } else if (this.stacks[end].length === 0 ||
      (this.stacks[end][0] > this.stacks[start][0])) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (start, end) {
  if (this.isValidMove(start, end)) {
    this.stacks[end].unshift(this.stacks[start].shift());
    return true;
  } else {
    console.log("Invalid move!");
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  var h = this;

  h.reader.question("Pick your start tower\n", function(answer) {
    h.reader.question("Pick your end tower\n", function(answer2) {
      var startMove = answer;
      var endMove = answer2;
      callback(startMove, endMove);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  this.promptMove(function (start, end) {
    this.move(start, end);

    if (!this.isWon()) {
      this.run(completionCallback);
    } else {
      console.log("You've won the game!")
      completionCallback();
      return;
    }
  }.bind(this));
};

var hanoiGame = new HanoiGame();
hanoiGame.run(function () {
  hanoiGame.reader.close();
});
