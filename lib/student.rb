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
    if self.id
      self.update
    else
      sql = <<-SQL 
      INSERT INTO songs (name, grade)
      VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() from songs")[0][0]
  end
  
  def self.create 
    student = Student.new(name, grade)
    student.save
    student
  end
  
  def self.new_from_db
    new_student = Student.new(name, grade, id)
    new_student.save
    new_student
    
    DB[:conn].execute(self.name, self.grade, self.id)
  end
  
  def self.find_by_name
    
  end
  
  def update
    
  end

end
