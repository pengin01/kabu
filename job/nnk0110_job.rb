require 'open-uri'
require 'rubygems'
require 'hpricot'
require 'filename_properties'



# #############################################3
# 証券コードファイル出力ＪＯＢ
#
# 証券コードをHPから取得してファイル出力する。

  #証券コード取得URL\
  url = ["http://www.meigaracode.com/1meigaracode_ichiran.html",
  "http://www.meigaracode.com/2kabushiki_meigaracode.html",
  "http://www.meigaracode.com/3shouken_meigaracode.html",
  "http://www.meigaracode.com/4meigaracode_kensaku.html",
  "http://www.meigaracode.com/5joujou_meigaracode.html",
  "http://www.meigaracode.com/6meigaracode_list.html",
  "http://www.meigaracode.com/7kabushigaisha_meigaracode.html",
  "http://www.meigaracode.com/8zen_meigaracode.html",
  "http://www.meigaracode.com/9shijou_meigaracode.html"]

  file_name = FILE_NAME::OUT_PATH + FILE_NAME::BRAND_CODE + FILE_NAME::EXTENSIION
  foo = File.open(file_name,'w')

url.each{|_url|
  doc = Hpricot(open(_url))
  #puts doc
  
  tmp = doc/:span
  tmp.each { |span|
     out = span.inner_text.split(" ",2)
     foo.puts out[0] + "," + out[1]
     inserted = true
  }
}
  foo.close
  puts "end"
