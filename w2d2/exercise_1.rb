class Employee
  attr_reader :salary

  def initialize(options)
    @name = options[:name]
    @salary = options[:salary]
    @title = options[:title]
    @boss = options[:boss]
    @boss.add_employee(self) if @boss
  end

  def bonus(num)
    @salary * num
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(options)
    super(options)
    @employees = []
  end

  def add_employee(employee)
    @employees << employee
  end

  def bonus(num)
    team_salary * num
  end

  def team_salary
    result = 0
    @employees.each do |employee|
      result += employee.team_salary if employee.class == Manager
      result += employee.salary
    end
    result
  end
end

# tests
# 
# ned = Manager.new({
#   name: 'Ned',
#   salary: 1_000_000,
#   title: 'Founder'
#   })
#
# darren = Manager.new({
#   name: 'Darren',
#   salary: 78_000,
#   title: 'TA Manager',
#   boss: ned
#   })
#
# shawna = Employee.new({
#   name: 'Shawna',
#   salary: 12_000,
#   title: 'TA',
#   boss: darren
#   })
#
# david = Employee.new({
#   name: 'David',
#   salary: 10_000,
#   title: 'TA',
#   boss: darren
#   })
#
# p ned.bonus(5)
# p darren.bonus(4)
# p david.bonus(3)
