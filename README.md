# TeorVero

This gem allows you to use the basic formulas of probability theory from the section on discrete random variables.

## Installationbundle lock --add-platform x86_64-linux
Install the gem and add to the application's Gemfile by executing:

    $ bundle add TeorVero

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install TeorVero

## Usage

You can calculate the expected value with
'''ruby
matojid(x, y=:None)
'''
Here and below, x can take the following data types:
1. x = 



You can calculate the random variable variance with
'''ruby
dispersion.create(hashValProb)
'''


You can calculate the standard deviation with
'''ruby
standardDev(hashValProb)
'''


You can calculate the binomial distribution with
'''ruby
binomialDis(n, k, p)
'''
Input parameters:
n - number of independent events; 
k - number of occurrences of the event; 
p - probability of occurrence of one event.
Result:
probability of occurrence of a possible value of k from n independent trials



You can calculate the binomial expected value with
'''ruby
binExpectVal(n, p)
'''
Input parameters:
n - number of values; 
p - the probability of occurrence of a value


You can calculate the binomial random variable variance with
'''ruby
binDisper(n, p)
'''
Input parameters:
n - number of values;
p - the probability of occurrence of a value.



You can calculate the binomial standard deviation with
'''ruby
binStandardDev(n, p)
'''
input parameters:
n - number of values; 
p - the probability of occurrence of a value.


You can calculate the сumulative distribution function
'''ruby
distibFun(hashValProb)
'''

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
