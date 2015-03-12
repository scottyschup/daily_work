require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    table = DBConnection.execute2(<<-SQL)
      SELECT * FROM #{table_name} LIMIT 1
    SQL

    table.first.map(&:to_sym)
  end

  def self.finalize!
    cols = columns
    cols.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method(:"#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
      @table_name = table_name
  end

  def self.table_name
    @table_name ||= to_s.tableize
  end

  def self.all
    query = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
    SQL

    results = DBConnection.execute(query)
    results.empty? ? nil : parse_all(results)
  end

  def self.parse_all(results)
    results.map do |result|
      new(result)
    end
  end

  def self.find(id)
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL

    results = DBConnection.execute(query, id)
    results.empty? ? nil : self.parse_all(results).first

  end

  def initialize(params = {})
    params.each do |key, value|
      key = key.to_sym

      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key)

      send(:"#{key}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col_name|
      send(col_name)
    end
  end

  def insert
    cols = self.class.columns
    q_marks_arr = ['?'] * cols.length
    col_names = cols.join(', ')
    q_marks = q_marks_arr.join(', ')

    query = <<-SQL
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{q_marks})
    SQL

    DBConnection.execute(query, *attribute_values)
    new_id = DBConnection.last_insert_row_id
    send(:id=, new_id)
  end

  def update
    cols = self.class.columns
    set = cols.map do |col_name|
      "#{col_name} = ?"
    end
    set = set.join(', ')

    query = <<-SQL
      UPDATE
        #{self.class.table_name}
      SET
        #{set}
      WHERE
        id = ?
    SQL

    values = attribute_values << id
    DBConnection.execute(query, *values)
  end

  def save
    id.nil? ? insert : update
  end
end
