require 'net/http'
require 'rubygems'
require 'kconv'
require 'hpricot'
require 'dbi'
require 'connection_maker.rb'
require 'lookup_get.rb'

#会社情報取得(最低購入枚数)－ファイル出力

def search(num,file_name)

  String url = "stocks.finance.yahoo.co.jp"
  String url_1 = "/stocks/profile/?code=" + num


  Net::HTTP.version_1_2
  Net::HTTP.start(url, 80) {|http|

    #      response = http.post('/stocks/profile/', url_1 )
    response = http.request_get( url_1 )


    doc = Hpricot(response.body)
    foo = File.open(file_name,'a')
    tmp = doc/"table[@cellpadding='0']"

    tmp.each { |table|
     (table/"tr").each { |tr|
        tds = tr/"td"

        if ( tds[0].inner_text.gsub(/,/, "").toutf8 =~ /(\d+)株/)

          foo.puts [num, tds[0].inner_text].join(" ").gsub(/,/, "").gsub(/株/, "").gsub(/---/, "0").gsub(/ /, ",").toutf8
          inserted = true

        end
      }
    }

    foo.close
  }
end

conn = ConectionMaker.new.getConnct()
file_name = LookupGet.new.getLookup(conn,"FILE_NAME","CORPORATE_INFO_UNDER_STOCK")
f = File.open(file_name,'w')
f.close




sth = conn.execute("SELECT CD_BRAND FROM NNK_CORPORATE_INFO WHERE ACTIVE_FLG = '1'")
sth.fetch_hash do |row|

  cd_brand = row["CD_BRAND"]
  puts cd_brand
  search(cd_brand,file_name)
end
sth.finish

puts "end"

