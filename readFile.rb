require("opeday_get.rb")

lines = fields = 0



opeday = OpedayGet.new
opeday.get_ope()

#open("foo.txt") {|file|
#  while l = file.gets
#    num = l.split(',')
#    puts num[0]
#  end
#}

