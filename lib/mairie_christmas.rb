require 'nokogiri'
require 'open-uri'

def init
  url = "https://annuaire-des-mairies.com/val-d-oise.html"
  page = Nokogiri::HTML(URI.open(url))
  data = page.xpath('//p/a/@href')
  return data
end

def make_townhall_url(data)
  names = []
  townhalls_url = []
  townhall_url = []
    data.each do |row|
      name = row.text
      names << name[1..-1]
    end
    names.each do |i|
      townhall_url = "https://annuaire-des-mairies.com#{i}"
      townhalls_url << townhall_url
    end
  return townhalls_url
end

def find_mail(townhalls_url)
  mails = []
  townhalls_url.each do |t_url|
    page_towns = Nokogiri::HTML(URI.open(t_url))
    town_data = page_towns.xpath('//*[contains(text(), "@")]')
    town_data = town_data.text
    mails << town_data
  end
  return mails
end

def find_town_name(townhalls_url)
  names = []
  townhalls_url.each do |t_url|
    page_towns = Nokogiri::HTML(URI.open(t_url))
    town_data = page_towns.xpath('/html/body/div/main/section[1]/div/div/div/p[1]/strong[1]/a')
    town_data = town_data.text
    names << town_data
  end
  return names
end

def make_hash(names, mails)
  tmp_hash = Hash.new
    tmp_hash = names.zip(mails).to_h
  return tmp_hash
end

def menu
  system "clear"
  puts "Selectionnez les valeurs à afficher :"
  puts
  puts "[1] Les url des villes"
  puts
  puts "[2] le nom des villes"
  puts
  puts "[3] L'email des villes"
  puts
  puts "[4] Le Hash en Array Nom/Email des villes"
  puts
  puts "[5] Le Hash Nom/Email des villes"
  puts
  puts "Toute autre valeur = Exit"
  puts
  print "> "
  input = gets.chomp.to_i
end


def perform
  data = init
  townhalls_url = make_townhall_url(data)
  mails = find_mail(townhalls_url)
  names = find_town_name(townhalls_url)
  tmp_hash = make_hash(names, mails)
  case menu
  when 1
    system "clear"
    puts townhalls_url
    print "Enter to return at menu"
        option = gets
        perform
  when 2
    system "clear"
    puts names
    print "Enter to return at menu"
        option = gets
        perform
  when 3
    system "clear"
    puts mails
    print "Enter to return at menu"
        option = gets
        perform
  when 4
    system "clear"
    names_mails = tmp_hash.to_a
    puts names_mails
    print "Enter to return at menu"
        option = gets
        perform
  when 5
    system "clear"
    puts tmp_hash
    print "Enter to return at menu"
        option = gets
        perform
  end
end

perform