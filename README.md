# ParseSberbankHtml

Parses Sberbank Online html

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'parse_sberbank_html'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parse_sberbank_html

## Usage

```ruby
transfers = sberbank_parser.parse_html some_downloaded_html
transfers.each do |t|
  puts t
end
````

## Contributing

1. Fork it ( https://github.com/[my-github-username]/parse_sberbank_html/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
