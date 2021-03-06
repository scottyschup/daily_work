require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    options[:foreign_key] ||= :"#{name}_id"
    options[:class_name]  ||= name.to_s.camelize
    options[:primary_key] ||= :id

    options.each do |key, value|
      # instance_variable_set("@#{key}", value) # what I came up with
      self.send("#{key}=", value) # aA solution
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:foreign_key] ||= :"#{self_class_name.underscore  }_id"
    options[:class_name] ||= name.to_s.singularize.camelize
    options[:primary_key] ||= :id

    options.each do |key, value|
      # instance_variable_set("@#{key}", value) # what I came up with
      self.send("#{key}=", value) # I'm guessing this is aA's solution?
    end

    options
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {}) # class method !!!
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do # makes an instance method !!!
      options = self.class.assoc_options[name]
      key_val = self.send(options.foreign_key)

      options
        .model_class
        .where(options.primary_key => key_val)
        .first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]

      key_val = self.send(options.primary_key)
      options
        .model_class
        .where(options.foreign_key => key_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end

class SQLObject
  extend Associatable
end
