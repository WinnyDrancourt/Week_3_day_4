require 'nokogiri'
require 'open-uri'

def init
  url = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(URI.open(url))
  data = page.xpath('.//tr[@class="cmc-table-row"]')
  return data
end

def extract_names(data)
  names = []
  data.search('tr').each do |row|
    name = row.at_xpath('.//td[3]').text
    names << name
  end
  return names
end

def extract_prices(data)
  prices = []
  data.search('tr').each do |row|
    price = row.at_xpath('.//td[5]').text
    prices << price
  end
  return prices
end

def make_hash(names, prices)
  tmp_hash = Hash.new
    tmp_hash = names.zip(prices).to_h
  return tmp_hash
end

def menu
  system "clear"
  puts "Selectionnez les valeurs à afficher :"
  puts
  puts "[1] Les valeurs data extraite avec le .txt"
  puts
  puts "[2] Le Hash Crypto/Valeurs"
  puts
  puts "[3] Le Hash en Array Crypto/Valeurs"
  puts
  puts "Toute autre valeur = Exit"
  puts
  print "> "
  input = gets.chomp.to_i
end

def perform
  data = init
  names = extract_names(data)
  prices = extract_prices(data)
  tmp_hash = make_hash(names, prices)
  case menu
    when 1
        system "clear"
        print "Data : #{names}"
        puts
        print "Data : #{prices}"
        puts
        print "Enter to return at menu"
        option = gets
        perform
    when 2
      system "clear"
      puts tmp_hash
      print "Enter to return at menu"
        option = gets
        perform
    when 3
      system "clear"
      crypto_ = tmp_hash.to_a
      puts crypto_
      print "Enter to return at menu"
        option = gets
        perform
  end
end

perform
