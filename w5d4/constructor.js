function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  console.log(this.owner + " loves " + this.name);
};

var felix = new Cat('Felix', 'Beth');
var cm = new Cat('Chairman Meow', 'Scott');

felix.cuteStatement();
cm.cuteStatement();

Cat.prototype.cuteStatement = function () {
  console.log("Everyone loves " + this.name + "!");
};

cm.cuteStatement();
felix.cuteStatement();

Cat.prototype.meow = function () {
  console.log("MEEOOOWWW");
};

cm.meow = function () {
  console.log("Say my name");
};

cm.meow();
felix.meow();
