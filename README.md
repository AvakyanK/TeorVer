# TeorVero

This gem allows you to use the basic formulas of probability theory from the section on discrete random variables.

## Installationbundle lock --add-platform x86_64-linux
Install the gem and add to the application's Gemfile by executing:

    $ bundle add TeorVero

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install TeorVero

## Usage

matojid (x,y)
принимает значения случайной величины х (которая содержит уникальные значения по определению) с вероятностями р


You can calculate the expected value with
'''ruby
matojid(x,y)
'''


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
binDis(p, n, k)
'''


You can calculate the binomial expected value with
'''ruby
binExpectVal(n, p)
'''


You can calculate the binomial random variable variance with
'''ruby
binDisper(n, p)
'''


You can calculate the binomial standard deviation with
'''ruby
binDisper(n, p)
'''


You can calculate the сumulative distribution function
'''ruby
distibFun(hashValProb)
'''

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
