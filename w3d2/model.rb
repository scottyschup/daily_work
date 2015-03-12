require 'active_support/inflector'

class DBModel
  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.to_s.downcase.pluralize}
    SQL

    results.map { |result| self.new(result) }
  end

  def self.method_missing(method_name, *args)
    method_name = method_name.to_s

    if method_name.start_with?("find_by_")
      method_name.slice!("find_by_")
      column_names = method_name.split('_and_')

      where_arr = []
      until column_names.empty?
        temp = "#{column_names.shift} = ?"
        where_arr << temp
      end
      where_str = where_arr.join(" AND ")

      sql_str = <<-SQL
        SELECT
          *
        FROM
          #{self.to_s.downcase.pluralize}
        WHERE
          #{where_str}
      SQL

      result = QuestionsDatabase.instance.execute(sql_str, *args).first
      self.new(result)
    else
      super
    end
  end

  def save(table)
    ivars = instance_variables.drop(1)
    vals = ivars.map { |ivar| instance_variable_get(ivar) }
    ivar_strs = ivars.map { |ivar| ivar.to_s[1..-1] }

    if id.nil?
      q_marks = Array.new(vals.length, '?')
      sql_str = <<-SQL
        INSERT INTO
          #{table} (#{ivar_strs.join(', ')})
        VALUES
          (#{q_marks.join(', ')})
      SQL
    else
      vals << id
      sql_str = <<-SQL
        UPDATE
          #{table}
        SET
          #{ivar_strs.join(' = ?, ')} = ?
        WHERE
          id = ?
      SQL
    end

    QuestionsDatabase.instance.execute(sql_str, *vals)
    self.id = QuestionsDatabase.instance.last_insert_row_id if id.nil?

    self
  end
end
