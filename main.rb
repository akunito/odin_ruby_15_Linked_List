# You will need two classes:
#   LinkedList class, which will represent the full list.
#   Node class, containing a #value method and a link to the #next_node, set both as nil by default.
#
# Build the following methods in your linked list class:
#
#   #append(value) adds a new node containing value to the end of the list
#   #prepend(value) adds a new node containing value to the start of the list
#   #size returns the total number of nodes in the list
#   #head returns the first node in the list
#   #tail returns the last node in the list
#   #at(index) returns the node at the given index
#   #pop removes the last element from the list
#   #contains?(value) returns true if the passed in value is in the list and otherwise returns false.
#   #find(value) returns the index of the node containing value, or nil if not found.
#   #to_s represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil

class LinkedList
  # represent linked list
  def initialize(first_node)
    @first_node = first_node
  end

  def append(value)
    # adds a new node containing value to the end of the list
    new_node = Node.new(value)
    last_node = tail
    last_node.edit_next(new_node)
  end

  def prepend(value)
    # adds a new node containing value to the start of the list
    new_node = Node.new(value)
    new_node.edit_next(@first_node)
    @first_node = new_node
  end

  def size
    count = 0
    count += 1 if @first_node
    if @first_node.next_node
      next_node = @first_node.next_node
      count += 1
    end
    until next_node.next_node.nil?
      count += 1
      next_node = next_node.next_node
    end
    count
  end

  def head
    @first_node
  end

  def tail
    if @first_node.next_node.nil?
      @first_node
    else
      last_node = @first_node.next_node
      until last_node.next_node.nil?
        last_node = last_node.next_node
      end
      last_node
    end
  end

  def at(index)
    # #at(index) returns the node at the given index
    if index.zero?
      @first_node
    elsif index < itself.size
      count = 1
      next_node = @first_node.next_node
      while count != index
        next_node = next_node.next_node
        count += 1
      end
      next_node
    else
      puts "node not found, note that list size is #{itself.size} without counting 0"
    end
  end

  def pop
    # removes the last element from the list
    tail.edit_value(nil)
    new_last_node = at(itself.size-2)
    new_last_node.edit_next(nil)
  end

  def contains(value)
    if @first_node.value == value
      @first_node
    else
      next_node = @first_node.next_node
      until next_node.next_node.nil?
        next_node = next_node.next_node
        return next_node if next_node.value == value
      end
      "Value Not Found"
    end
  end

  def find(value)
    # #find(value) returns the index of the node containing value, or nil if not found.
    count = 0
    if @first_node.value == value
      return count
    else
      next_node = @first_node.next_node
      count += 1
      return count if next_node.value == value
      until next_node.next_node.nil?
        next_node = next_node.next_node
        count += 1
        return count if next_node.value == value
      end
    end
    "Value Not Found"
  end

  def insert_at(value, index)
    # #insert_at(value, index) that inserts a new node with the provided value at the given index
    if index.zero?
      prepend(value)
    elsif index > itself.size-1
      append(value)
    else
      # get previous, new and next nodes
      before_node = at(index-1)
      after_node = at(index)
      new_node = Node.new(value)
      # point previous node to the new one
      before_node.edit_next(new_node)
      # point new node to the next node
      new_node.edit_next(after_node)
    end
  end

  def remove_at(index)
    # #remove_at(index) that removes the node at the given index
    begin
      if index.zero?
        @first_node = at(1)
      elsif index == itself.size-1
        pop
      else
        # get previous and next nodes
        before_node = at(index-1)
        after_node = at(index+1)
        # point previous to next skipping the middle node
        before_node.edit_next(after_node)
      end
    rescue
      "Node Not Found"
    end
  end

  def to_s(node)
    p "Node Address: #{node} | Value: #{node.value} | Next Node: #{node.next_node}"
  end

  def print
    puts "\n---- Listing #{itself.size} nodes from LinkedList ----"
    to_s(@first_node)
    next_node = @first_node.next_node
    until next_node.next_node.nil?
      to_s(next_node)
      next_node = next_node.next_node
    end
    to_s(next_node)
  end
end

class Node
  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end

  def value
    @value
  end

  def next_node
    @next_node
  end

  def edit_value(value)
    @value = value
  end

  def edit_next(next_node)
    @next_node = next_node
  end
end

puts "starting"
n1 = Node.new(100)

list1 = LinkedList.new(n1)
list1.append(200)
list1.append(300)

list1.prepend(-100)
list1.prepend(-200)

list1.print

puts "\npop"
list1.pop

list1.print

puts ""
p list1.find(200)

puts "\ninsert at"
list1.insert_at(150, 3)
list1.print

puts "\nremove at"
list1.remove_at(4)
list1.print