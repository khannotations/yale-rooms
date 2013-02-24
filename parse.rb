require 'nokogiri'
page = Nokogiri::HTML(open("rooms.txt")) 

rooms = []
# string = "Room.create(["
string = ""
page.css(".ListText").each do |node|
  text = node.text
  if /^\w/ =~ text and not rooms.include? text
    rooms << text
    parts = text.split " "
    name = parts[0]
    # string+="\n\t{\n\t\tname: \"#{name}\",\n\t\tnumber: \"#{parts[1]}\",\n\t\tlocation: "
    string += "<option value='#{name}-#{parts[1]}'>#{text}</option>\n"
    # if /^WLH/ =~ name
    #   string+="\"100 Wall Street, New Haven, CT\""
    # elsif /^LC/ =~ name
    #   string+="\"63 High Street, New Haven, CT\""
    # else
    #   string+="\"Not known just quite yet\""
    # end
    # string+="\n\t},"
  end
end
# string+="\n])"

puts string

