function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
}

Student.prototype.name = function () {
  return this.fname + ' ' + this.lname;
};
