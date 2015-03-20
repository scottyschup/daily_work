Array.prototype.uniq = function () {
  var results = [];
  for (var i = 0; i < this.length; i++) {
    if (results.indexOf(this[i]) < 0) {
      results.push(this[i]);
    }
  }
  return results;
};

// var test = [1, 2, 3, 4, 4, 4, 4].uniq();
// console.log(test);

Array.prototype.twoSum = function () {
  var result = [];
  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if(this[i] + this[j] === 0) {
        result.push([i, j]);
      }
    }
  }

  return result;
};

// var test = [-1, 0, 2, -2, 1].twoSum();
// console.log(test)

Array.prototype.myTranspose = function () {
  var transposeArr = [];
  for (var i = 0; i < this.length; i++) {
    transposeArr.push([]);
    for (var j = 0; j < this.length; j++) {
      transposeArr[i].push(this[j][i]);
    }
  }

  return transposeArr;
};

// var test = [
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ].myTranspose();
//
//
// console.log(test);

Array.prototype.myEach = function (f) {
  for (var i = 0; i < this.length; i++) {
    f(this[i]);
  }
  return this;
};

// var test = [1, 2, 3, 4].myEach(function (el) {
//   return el * 2;
// });
//
// console.log(test);

Array.prototype.myMap = function(f) {
  var result = [];
  this.myEach(function (el) {
    result.push(f(el));
  });

  return result;
};

// var test = [1, 2, 3, 4].myMap(function (el) {
//   return el * 2;
// });
//
// console.log(test);

Array.prototype.myInject = function(f) {
  var result = this[0];
  this.slice(1, this.length).myEach(function(el) {
    result = f(result, el);
  });

  return result
};

// var test = ["a", "a", "a", "a"].myInject(function (product, n) {
//   return product + n;
// });
//
// console.log(test)

var bubbleSort = function(arr) {
  var unsorted = true;
  while(unsorted) {
    unsorted = false;
    for(var i = 0; i < arr.length - 1; i++) {
      if(arr[i] > arr[i+1]) {
        var tmp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = tmp;
        unsorted = true;
      }
    }
  }

  return arr;
};

// console.log(bubbleSort([5,4,3,2,1]));

var substrings = function (str) {
  var arr = [];
  for(var i = 0; i < str.length; i++) {
    for(var j = i + 1; j <= str.length; j++) {
      if (arr.indexOf(str.slice(i, j)) < 0) {
        arr.push(str.slice(i, j));
      }
    }
  }

  return arr;
};

// var test = 'that';
// console.log(substrings(test));

var range = function(start, end) {
  if(start > end) {
    return [];
  }

  return [start].concat(range(start + 1, end));
};

var test = range(5, 10);
// console.log(test)

var sum = function(arr) {
  var sum = 0;
  for(var i = 0; i < arr.length; i++) {
    sum += arr[i];
  }

  return sum;
};

var testSum = sum(test);

console.log(testSum);

var recSum = function(arr) {
  if(arr.length === 0){
    return 0;
  }

  return arr[0] + recSum(arr.slice(1, arr.length));
};

// var testSum = recSum(test);
//
// console.log(testSum);

var exp1 = function(base, exp) {
  if(exp === 0){
    return 1;
  }

  return base * exp1(base, exp - 1);
};

var exp2 = function(base, exp) {
  if(exp === 0) {
    return 1;
  }

  if (exp % 2 === 0) {
    return Math.pow(exp2(base, exp / 2), 2);
  } else {
    return base * Math.pow(exp2(base, (exp - 1) / 2), 2);
  }
};

// console.log(exp2(3, 3));

var fibonacci = function (num) {
  if (num === 0) {
    return [];
  } else if (num === 1) {
    return [1];
  } else if (num === 2) {
    return [1,1];
  }

  var arr = fibonacci(num - 1);

  return arr.concat(arr[arr.length - 1] + arr[arr.length - 2]);
};

// var fib = fibonacci(5);
// console.log(fib);

var bsearch = function(arr, target) {
  if (arr.length === 0) {
    return null;
  }
  var mid = Math.floor(arr.length / 2);
  var left = arr.slice(0, mid);
  var right = arr.slice(mid + 1, arr.length);

  if (arr[mid] === target) {
    return mid;
  } else if(arr[mid] < target) {
    var rightSearch = bsearch(right, target);

    if (rightSearch !== null) {
      return mid + 1 + rightSearch;
    }
  } else {
    var leftSearch = bsearch(left, target);

    if (leftSearch !== null) {
      return leftSearch;
    }
  }

  return null;
};

// var test = bsearch(range(0,50).concat(range(52, 100)), 70);
//
// console.log(test);

var makeChange = function(amt, coins) {
  if(amt === 0){
    return [];
  }

  var result = [];

  while (amt >= coins[0]) {
    amt -= coins[0];
    result.push(coins[0]);
    console.log(amt);
  }

  return result.concat(makeChange(amt, coins.slice(1, coins.length)));
};

// var test = makeChange(99, [25, 10, 5, 1]);
// console.log(test);

var makeChange = function(amt, coins) {
  if(amt === 0) {
    return [];
  }

  var result = [];

  while (amt >= coins[0]) {
    amt -= coins[0];
    result.push(coins[0]);
    console.log(amt);
  }

  return result.concat(makeChange(amt, coins.slice(1, coins.length)));
};

var makeEffenChange = function(amt, coins) {
  if(amt === 0) {
    return [];
  } else if (coins.length === 0) {
    return null;
  } else if (amt < coins[coins.length - 1]) {
    return null;
  }


  // else if (coins.length < 2 && amt < coins[0]) {
  //   return [];
  // }

  var bestChange = null;

  for (var i = 0; i < coins.length; i++) {
    console.log("a");
    var remainder = 0;
    var bestRemainder = [];
    var thisChange = [];

    if (amt < coins[i]) {
      continue;
    }

    remainder = amt - coins[i];

    bestRemainder = makeEffenChange(remainder, coins.slice(i + 1, coins.length));

    console.log(bestChange)

    if(bestRemainder === null){
      continue;
    }

    thisChange = [coins[i]].concat(bestRemainder);
    console.log(thisChange)


    if(bestChange === null || thisChange.length < bestChange.length){
      bestChange = thisChange;
    }
  }

  return bestChange;

};


var test = makeEffenChange(8, [6, 4, 1]);

console.log(test);
