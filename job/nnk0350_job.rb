require 'net/http'
require 'rubygems'
require 'kconv'
require 'hpricot'
require 'dbi'
require 'connection_maker.rb'
require 'opeday_get.rb'
require 'lookup_get.rb'

#株価情報取得（日足）ファイル出力ＪＯＢ

def search(num,file_name, ope_day)


  year = ope_day[0..3].to_i.to_s
  month = ope_day[4..5].to_i.to_s
  day = ope_day[6..7].to_i.to_s

  Net::HTTP.version_1_2
  Net::HTTP.start("table.yahoo.co.jp", 80) {|http|

    #      String url = "c=2009&a=1&b=1&f=2009&d=12&e=31&g=w&s=" + num + "&y=0&z=" + num + ".q"
    String url = "c=" + year + "&a=" + month + "&b=" + day + "&f=" + year + "&d=" + month + "&e=" + "1" + "&g=d&s=" + num + "&y=0&z=" + num + ".q"
    puts url
    #      http://table.yahoo.co.jp/t?c=2009&a=4&b=6&f=2009&d=7&e=8&g=d&s=8027&y=0&z=8027.o&x=sb

    #      response = http.post('/t','c=2007&a=12&b=1&f=2008&d=12&e=7&g=w&s=1751&y=0&z=1751.q')
    response = http.post('/t', url )

    doc = Hpricot(Kconv.kconv(response.body,Kconv::UTF8))
    #    puts doc
    foo = File.open(file_name,'a')
    tmp = doc/"table[@cellpadding='5']"
    # puts tmp
    tmp.each { |table|
     (table/"tr").each { |tr|
        tds = tr/"td"

        if ( tds.length > 4 && tds[0].inner_text.toutf8 =~ /(\d+)年(\d+)月(\d+)日/ )
          foo.puts [num, tds[0].inner_text, tds[1].inner_text, tds[2].inner_text,
          tds[3].inner_text, tds[4].inner_text, tds[5].inner_text].join(" ").gsub(/年/, "-").gsub(/月/, "-").gsub(/日/, "").gsub(/,/, "").gsub(/ /, ",")
          inserted = true
        end
      }
    }

    foo.close
  }
end

conn = ConectionMaker.new.getConnct()
ope_day = OpedayGet.new.get_ope(conn)
file_name = LookupGet.new.getLookup(conn,"FILE_NAME","STOCK_PRICES_DAILY")

f = File.open(file_name,'w')
f.close

sth = conn.execute("SELECT CD_BRAND FROM NNK_CORPORATE_INFO WHERE ACTIVE_FLG = '1' AND FL_DEALINGS_TARGET = '1'")
sth.fetch_hash do |row|

  cd_brand = row["CD_BRAND"]
  puts cd_brand
  search(cd_brand,file_name,ope_day)

end
sth.finish


puts "end"

