class MyHashSet
  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.has_key?(el)
  end

  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      true
    else
      false
    end
  end

  def to_a
    result = []
    @store.each do |key, value|
      result << key
    end
    result
  end

  def union(set2)
    self.merge(set2)
  end

  def intersect(set2)
    result = {}
    self.each do |key, value|
      if set2.include?(key)
        result[key] = value
      end
    end
    result
  end

  def minus(set2)
    result = {}
    self.each do |key, value|
      result[key] = value unless set2.include?(key)
    end
  end

end
