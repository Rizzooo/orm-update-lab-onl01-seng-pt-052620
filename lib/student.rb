require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name 
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
      id INTEGER PRIMARY KEY, 
      name TEXT, 
      grade INTEGER
      )
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS songs"
    
    DB[:conn].execute(sql)
  end
  
  def save 
    sql = <<-SQL 
      INSERT INTO songs (name, grade)
      VALUES (?, ?)
    SQL
  end

end
