# Some examples of anonymouse functions.
# These can be used alot in elixir if the functions doesn't seem very reusable
add = fn a, b -> a+b end
IO.puts add.(5,3)

subtract = fn a, b, c -> a-b-c end
IO.puts(subtract.(100,50,25)) # This is one way to write this...
subtract.(100,50,25) |> IO.puts() # This is the CORRECT WAY to write this!

could_be_any_num_ooo = -5
# Showcasing the power of Piping functions for readablity.
# no more a(b(c())) or creating variables for no other reason other than a place
# to very very temporarily hold the ouput of something that we only need on the
# very next line anyway.
could_be_any_num_ooo |> abs |> Integer.to_string |> IO.puts

# We concat 2 lists together like so: list ++ list
[1,2,3] ++ [true, "this", :that] |> Enum.each(fn x -> IO.puts(x) end)

# We can store anything in "generic" variables
items = [1,2,3] ++ [true, "this", :that]

# This is basically a traditional for each loop.
for item <- items do
  IO.inspect(item)
end

# This is more appropriate in Elixir
Enum.each(items, fn x -> IO.puts(x) end)

# There are tons of modules from Erlang that get imported automatically like this.
# but we REALLY should not do this. It won't work without we pipe
# data because this method expects the function first and then the list
# second.
:lists.foreach(fn a -> IO.puts(a) end, items) # wierd, don't do this.

# Here is an example module in Elixir that shows that 2 functions with
# the same name, but different arity are 2 different fucntions in elixir
# BIG NOTE: everything else will be ran at runtime when this file is imported or compiled
# But this module will only be compiled as there is nothing to run here anyways.
defmodule Rectangle do
  def area(a), do: area(a, a) # we are also using the one line method
  def area(a, b), do: a*b # for named functions here.
end
# The previous by extentions means that we cannot have 2 different functions with the
# same name and arity, because elixir will just use one all the time instead of the other.

Rectangle.area(5)
Rectangle.area(5, 10)

defmodule Calculator do
  def sum(a, b \\ 0) do # Here is an example of how we can initiate a argument using \\ operator
    a + b
  end
end

# This means the following will run regardless of a mismatch in arity:
Calculator.sum(7)

defmodule MyModule do
  def fun(a, b \\ 100, c, d \\ 1000) do
    a + b + c + d
  end
end

# As you can see, the way in which we chose to create our function
# designed in fact, 3 different functions with the same name,
# different arity.
# These will all work.
MyModule.fun(5, 10)
MyModule.fun(5, 10, 15)
MyModule.fun(5, 10, 15, 20)

# Remember, the following will NOT work
MyModule.fun(5, _, 10) # Elixir will throw an error: invalid use of _
# this is because _ represents a value to be ignored in a pattern,
# and cannot be used in expressions.
