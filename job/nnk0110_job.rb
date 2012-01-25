$LOAD_PATH << File.dirname(__FILE__)
require 'net/http'
require 'rubygems'
require 'kconv'
require 'hpricot'
require './connection_maker.rb'
require 'lookup_get.rb'


# #############################################3
# 証券コードファイル出力ＪＯＢ
#
# 証券コードをHPから取得してファイル出力する。
Net::HTTP.version_1_2
Net::HTTP.start("www.meigaracode.com", 80) {|http|
  #  response = http.post('/9shijou_meigaracode.html')

  #証券コード取得URL
  String url_1 = "/1meigaracode_ichiran.html"
  String url_2 = "/2kabushiki_meigaracode.html"
  String url_3 = "/3shouken_meigaracode.html"
  String url_4 = "/4meigaracode_kensaku.html"
  String url_5 = "/5joujou_meigaracode.html"
  String url_6 = "/6meigaracode_list.html"
  String url_7 = "/7kabushigaisha_meigaracode.html"
  String url_8 = "/8zen_meigaracode.html"
  String url_9 = "/9shijou_meigaracode.html"

  response = http.request_get( url_8 )
  #  doc = Hpricot(Kconv.kconv(response.body,Kconv::UTF8))
  doc = Hpricot(response.body)
  #   puts doc

  conn = ConectionMaker.new.getConnct()
  file_name = LookupGet.new.getLookup(conn,"FILE_NAME","BRAND_CODE")

  foo = File.open(file_name,'w')
  tmp = doc/"table[@cellspacing='0']"
  #  puts tmp
  tmp.each { |table|
   (table/"tr").each { |tr|
      tds = tr/"td"
      #      puts tds
      #    puts tds[0].inner_text.toutf8.split(//u).length


      if ( tds.length >= 2 && tds[0].inner_text.toutf8.size > 0 && tds[1].inner_text.size == 4 )
        #    foo.puts [tds[1].inner_text.toutf8, tds[0].inner_text.toutf8].join(" ").gsub(/,/, "").gsub(/ /, ",").toutf8
        foo.puts [tds[1].inner_text, tds[0].inner_text].join(" ").gsub(/,/, "").gsub(/ /, ",").toutf8

        puts tds[1].inner_text.toutf8
        inserted = true
      end
    }
  }

  foo.close
  puts "end"
}