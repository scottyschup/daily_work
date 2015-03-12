class Student
  attr_reader :first_name, :last_name
  attr_accessor :courses

  def initialize first_name, last_name
    @first_name = first_name
    @last_name = last_name
    @courses = []
    @course_load = {}
  end

  def name
      "#{@first_name} #{@last_name}"
  end

  def enroll(course)
    unless @courses.include?(course)
      @courses << course
      course.add_student(self)
    end
  end

  def course_load
    courses.each do |course|
      @course_load[course.department] ?
        @course_load[course.department] += course.credits :
        @course_load[course.department] = course.credits
    end
    @course_load
  end
end

class Course
  attr_reader :course_name, :department, :credits
  def initialize(course_name, department, credits)
    @course_name = course_name
    @department = department
    @credits = credits
    @students = []
  end

  def students
    @students
  end

  def add_student(student)
    @students << student
  end
end
