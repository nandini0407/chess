class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end

end

class Manager < Employee

  attr_accessor :employees
  # attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @employees = []
  end

  def bonus(multiplier)
    queue = @employees.dup
    total_salary = 0
    until queue.empty?
      current_employee = queue.shift
      total_salary += current_employee.salary
      if current_employee.is_a?(Manager)
        current_employee.employees.each do |employee|
          queue << employee
        end
      end
    end
    total_salary * multiplier
  end

end

ned = Manager.new("Ned", "Founder", 1000000, nil)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
david = Employee.new("David", "TA", 10000, darren)
shawna = Employee.new("Shawna", "TA", 12000, darren)

darren.employees = [shawna, david]
ned.employees = [darren]
