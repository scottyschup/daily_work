require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    where_clause = params.keys.map { |key| "#{key} = ?" }.join(" AND ")
    query = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_clause}
    SQL

    results = DBConnection.execute(query, *params.values)
    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
