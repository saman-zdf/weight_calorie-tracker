require 'colorize'
require 'tty-prompt'
require 'terminal-table'
require 'json'
# create a class to get a user name, and data of food and calorie antake
class Calorierecorder < Terminal::Table
  # use attr_reader to be able to read the name 
  attr_reader :name

  # in initializa methos which is a private method I passed 1 arguments for name and create two instance variables for name and record, and assign record varriable to an empty array
  def initialize(name)
    @name = name
    @record = []
  end

  # create welcome method to welcome the to this app user
  def welcome 
    puts "Welcome to my calorie recorder app"
    puts "In this app you will be able to record your daily food intake with calorie and time of the day.".colorize(:cyan)
    puts "Please just follow the instruction and you will be able to use this app easily.".colorize(:cyan)
  end 

# create the get data method and pass three arguments, I store the variables as a value to the hash and then append it to my @record variables
  def get_data(type, number_of_cal, time_of_day)
    total = {food: type, calorie: number_of_cal, time: time_of_day}
    @record << total
  end
  # calorie recorder methods will gets the user input and store it to the get_data method
  def calorie_recorder
    puts "Please Enter the type of the food"
    type = gets.chomp
    puts "Please enter the number of calories"
    number_of_cal = gets.chomp.to_i
    puts "Please enter the time of the day"
    time = gets.chomp
    get_data(type, number_of_cal, time)
  end
  # create a display data  method and iterate through my @record array, to display the value of each hash
  def display_data
    @table = Terminal::Table.new do |t|
      rows = []
      t << :separator
      t.headings = ['Meal'.colorize(:yellow), 'Calories'.colorize(:yellow), 'Time of the day'.colorize(:yellow)]
      @record.each do |item|
        t << [item[:food], item[:calorie], item[:time] ] 
        t << :separator
        t.style = { :border_top => false, :border_bottom => false, :width => 80,:border_x => "=".colorize(:blue),:border_i => "*".colorize(:red)}
      end
    end
    puts @table
    File.write('test.json', JSON.dump(@table))
  end
  # create a history method to show the history of records, used jason file to read the data of user inputs.
  def history
    # puts @table
    # using map to get the sum of the calories
      sum_calorie = @record.map { |cal| cal[:calorie] }.sum
      puts "You have had #{@record.length} meals, and #{sum_calorie} calories in total.".colorize(:green)
      puts @table
      # file = File.read('./test.json')
      # data_hash = JSON.parse(file)
  end

end

