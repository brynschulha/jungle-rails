MoneyRails.configure do |config|
  puts "is this working?"
  config.no_cents_if_whole = false
end