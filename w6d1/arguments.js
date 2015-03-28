// var sum = function() {
//   var results = 0;
//   for (var i = 0; i < arguments.length; i++) {
//     results += arguments[i];
//   }
//   return results;
// };

Function.prototype.myBind = function(context) {
  var args = Array.prototype.slice.call(arguments, 1);
  var fn = this;
  return function () {
    var fullArgs = args.concat(Array.prototype.slice.call(arguments));
    return fn.apply(context, fullArgs);
  };
};

var curriedSum = function(numArgs) {
  var numbers = [];
  
  return _curriedSum = function(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      var results = 0;
      for (var i = 0; i < numbers.length; i++) {
        results += numbers[i];
      }
      return results;
    }
    return _curriedSum;
  };
};

// var sum = curriedSum(5);
// console.log(sum(1));
// console.log(sum(1)(2)(3)(4)(5));

Function.prototype.curry = function (numArgs) {
  var args = [];
  var fn = this;
  return _curriedFn = function(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return fn.apply(this, args);
    }
    return _curriedFn;
  };
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

var f1 = sumThree.curry(3);
console.log(f1(4)(20)(6));
