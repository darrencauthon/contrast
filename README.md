# Contrast [![Build Status](https://secure.travis-ci.org/darrencauthon/contrast.png?branch=master)](http://travis-ci.org/darrencauthon/contrast)

This gem is meant to assist in comparing objects to others, most notably in tests and specs.

## Usage

Require contrast.

````ruby
require 'contrast'
````

Let's say you have two objects, like so:

````ruby
john = Person.new first_name: 'John', last_name: 'Galt', gender: 'm'
howard = Person.new first_name: 'Howard', last_name: 'Roark', gender: 'm'
````

You can contrast the two objects, providing the attributes by which to compare them:

````ruby
john.contrast_with howard, [:first_name, :last_name, :gender]
# {:first_name=>{:actual_value=>"Howard", :expected_value=>"John"},
#  :last_name=>{:actual_value=>"Roark", :expected_value=>"Galt"}}
````

Note that it did not show a result for gender, as they matched.

If you call contrast_with!, an exception will be thrown if the two objects do not match based on the provided fields.

````ruby
john.contrast_with! howard, [:first_name, :last_name, :gender]
# An exception was just thrown, showing the fields that do not match in the message.
````

You can also compare objects to hashes, and hashes to hashes:

````ruby
john.contrast_with { first_name: 'Dagny', gender: 'f' }, [:gender]
# {:gender=>{:actual_value=>"m", :expected_value=>"f"}}
````

If you pass a hash to contrast_with, it will use the keys in the hash if a list of fields is not supplied.

````ruby
john.contrast_with { first_name: 'Dagny', gender: 'f' }
# {:gender=>{:actual_value=>"m", :expected_value=>"f"}}
````
