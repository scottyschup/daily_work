Function.prototype.inherits = function(parent) {
  function Surrogate() {}
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
};

function MovingObject () {};
MovingObject.prototype.move = function() {
  console.log('Wheeeee!');
};

function Ship () {};
Ship.inherits(MovingObject);

function Asteroid () {};
Asteroid.inherits(MovingObject);
Asteroid.prototype.explode = function() {
  console.log('KABOOM!');
};

var firefly = new Ship();
firefly.move();

var armageddon = new Asteroid();
armageddon.move();

armageddon.explode();
firefly.explode();
