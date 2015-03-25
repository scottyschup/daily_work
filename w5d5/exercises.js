Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  }
}

var Snowman =  function (first) {
  this.name = first
};

Snowman.prototype.getName = function () {
  return this.name
}
var o = new Snowman('olaf')
var f = new Snowman('frosty')

console.log(o.getName.myBind(f)());
console.log(o.getName());
