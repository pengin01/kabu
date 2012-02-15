$LOAD_PATH << File.dirname(__FILE__)
require 'open-uri'
require 'rubygems'
require 'kconv'
require 'hpricot'
require 'filename_properties'



# #############################################3
# 証券コードファイル出力ＪＯＢ
#
# 証券コードをHPから取得してファイル出力する。

  #証券コード取得URL
  String url_1 = "/1meigaracode_ichiran.html"
  String url_2 = "/2kabushiki_meigaracode.html"
  String url_3 = "/3shouken_meigaracode.html"
  String url_4 = "/4meigaracode_kensaku.html"
  String url_5 = "/5joujou_meigaracode.html"
  String url_6 = "/6meigaracode_list.html"
  String url_7 = "/7kabushigaisha_meigaracode.html"
  String url_8 = "http://www.meigaracode.com/8zen_meigaracode.html"
  String url_9 = "/9shijou_meigaracode.html"

  file_name = FILE_NAME::BRAND_CODE + FILE_NAME::EXTENSIION
  foo = File.open(file_name,'w')

  doc = Hpricot(open(url_8))
  #puts doc
  
  tmp = doc/:span
  tmp.each { |span|
     out = span.inner_text.split(" ",2)
     foo.puts out[0] + "," + out[1]
     inserted = true
  }

  foo.close
  puts "end"
