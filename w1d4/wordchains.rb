require 'set'
require 'byebug'

class WordChainer
  ALPHABET ||= ('a'..'z')
  DEFAULT_DICT ||= 'dictionary.txt'
  
  attr_reader :adjacent_words_list, :secondary_adjacent_words_list
  
  def initialize(dictionary_file_name = nil)
    dictionary_file_name ||= DEFAULT_DICT
    dictionary = File.readlines(dictionary_file_name).map { |line| line.chomp }
    @dictionary = Set.new(dictionary)
  end
  
  # private
  def adjacent_words(word)
    @adjacent_words_list ||= Hash.new { |h, k| h[k] = [] }
    
    @adjacent_words_list[word.to_sym] = get_adjacent_words(word)
  end
  
  def secondary_adjacent_words(word)
    adjacent_words(word) unless @adjacent_words_list.has_key? word.to_sym
    @secondary_adjacent_words_list ||= Hash.new { |h, k| h[k] = [] }
    this_list = []
    
    @adjacent_words_list[word.to_sym].each do |adj_word|
      this_list += get_adjacent_words(adj_word)
    end

    @secondary_adjacent_words_list[word.to_sym] = this_list.keep_if do |wrd|
      !@adjacent_words_list[word.to_sym].include?(wrd) &&
      word != wrd
    end
  end
  
  def get_adjacent_words(word)
    this_list = []
    (0...word.length).each do |i|
      ALPHABET.each do |char|
        new_word = search(possible_adjacent_word(word, char, i))
        this_list << new_word if new_word && !this_list.include?(new_word)
      end
    end
    this_list
  end
  
  def possible_adjacent_word(original_word, char, i)
    possible_word = original_word.dup
    possible_word[i] = char
    possible_word unless possible_word == original_word
  end
  
  def search(possible_word)
    possible_word if @dictionary.include?(possible_word)
  end
end

test = WordChainer.new
test.adjacent_words('ass')
p test.adjacent_words_list
test.secondary_adjacent_words('ass')
test.secondary_adjacent_words('son')
p test.secondary_adjacent_words_list
