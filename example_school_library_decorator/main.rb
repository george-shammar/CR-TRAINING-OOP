require './book'
require './rental'
require './student'
require './teacher'

class Library
  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def create_book
    puts 'Book Name'
    name = get.chomp.match('[a-zA-Z]+.*').string

    puts 'Book Author'
    author = get.chomp.match('[a-zA-Z]+.*').string

    new_book = Book.new(name, author)
    @books.push(new_book)
  end

  def create_person
    puts 'Are you a teacher or a student'
    puts 'Enter number one (1) for Teacher or number two (2) for Student'

    input = gets.chomp.to_i
    return unless [1, 2].include?(input)

    puts 'Enter your name'
    name = gets.chomp.match('[a-zA-Z]+.*').string

    puts 'Enter age'
    age = gets.chomp.match('1-9')

    person =
      if input == 1
        puts 'Specialization'
        spec = gets.chomp
        permission = true
        Teacher.new(age, spec, name, permission)
      elsif input == 2
        puts 'Does parent have permission (Y/N)'
        parent = gets.chomp.downcase
        parent_permission = parent == 'Y'
        Student.new(age, name, parent)
      end

    puts 'Added successfully'
    @people.push(person)
  end

  def create_rental
    puts 'Choose book'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end

    puts 'Date'
    date = gets.chomp

    puts 'Enter book index'
    book_index = gets.chomp.to_i

    puts "Enter a person's index"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Added successfully'
  end

  def list_books
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end
end

def main
  puts 'Welcome to OOP Library'

  processing = true
  library = Library.new

  while processing
    puts 'Please choose a number'
    puts '1 - list all books'
    puts '2 - list all people'
    puts '3 - create a person'
    puts '4 - create a book'
    puts '5 - create a rental'
    puts '6 - list all rentals'
    puts '7 - exit'

    user_entry = gets.chomp

    if user_entry == '7'
      puts ' '
      puts 'Are you sure you want Exit? Enter (Y) to exit'
      exit = gets.chomp

      if exit == 'Y'
        puts 'Goodbye'
        processing = false
      else
        puts ' '
        puts 'Continue with App'
        puts ' '
        processing = true
      end
    elsif user_entry == '1'
      library.list_books
    elsif user_entry == '2'
      library.list_people
    elsif user_entry == '3'
      library.create_person
    elsif user_entry == '4'
      library.create_book
    elsif user_entry == '5'
      library.list_books
    elsif user_entry == '6'
      library.list_all_rentals
    end
  end
end

main
