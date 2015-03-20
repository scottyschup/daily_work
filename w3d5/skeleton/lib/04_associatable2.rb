require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    self.assoc_options[name] =

    define_method(name) do
      # stuff here
    end
  end
end
