john = Student.new('John', 'Doe')
sam = Student.new('Sam', 'Smith')
beth = Student.new("Beth", "Baker")

math = Course.new('Math 101', 'Math', 3)
science = Course.new('Biology', 'Science', 4)
math2 = Course.new('Math 201', 'Math', 3)
science2 = Course.new('Anatomy', 'Science', 5)
english = Course.new('English Comp', 'English', 2)

set1 = [math, science, english, math2]
set2 = [science, science2, english]
set3 = [math2, science2, english, english]

set1.each do |course|
  john.enroll(course)
end
set2.each do |course|
  sam.enroll(course)
end
set3.each do |course|
  beth.enroll(course)
end
