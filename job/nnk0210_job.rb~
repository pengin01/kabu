require 'net/http'
require 'rubygems'
require 'kconv'
require 'hpricot'
require 'dbi'
require 'connection_maker.rb'
require 'lookup_get.rb'

#会社情報取得－ファイル出力ＪＯＢ

def search(num,file_name)

  String url = "profile.yahoo.co.jp"
  String url_1 = "/independent/" + num

  Net::HTTP.version_1_2
  Net::HTTP.start(url, 80) {|http|

    response = http.request_get( url_1 )
    doc = Hpricot(Kconv.kconv(response.body,Kconv::UTF8))


    foo = File.open(file_name,'a')
    tmp = doc/"table[@cellpadding='5']"
    #    puts tmp

    bps = ""
    touri = ""

    tmp.each { |table|
     (table/"tr").each { |tr|
        tds = tr/"td"

        #        puts tds[0].inner_text

        if ( tds.length > 3 && (tds[0].inner_text =~ /BPS（一株当たり純資産）/))
          bps = [tds[1].inner_text, tds[2].inner_text, tds[3].inner_text].join(" ")

          #          puts bps
          #            foo.puts [num, tds[1].inner_text, tds[2].inner_text,tds[3].inner_text].join(" ").gsub(/,/, "").gsub(/円/, "").gsub(/万/, "000").gsub(/千/, "0000").gsub(/百/, "00").gsub(/ /, ",").toutf8
        end

        if ( tds.length > 3 && (tds[0].inner_text =~ /当期利益/))
          touri = [tds[1].inner_text, tds[2].inner_text, tds[3].inner_text].join(" ")
          #          puts tr
          #          inserted = true
        end

        if(bps != "" && tr != "")
          puts num
          foo.puts [num, bps, touri].join(" ").gsub(/,/, "").gsub(/円/, "").gsub(/万/, "000").gsub(/千/, "0000").gsub(/百/, "00").gsub(/---/, "").gsub(/ /, ",").toutf8
          inserted = true
          bps = ""
          touri = ""
        end
      }
    }

    foo.close
  }
end

#ファイル出力
conn = ConectionMaker.new.getConnct()
file_name = LookupGet.new.getLookup(conn,"FILE_NAME","CORPORATE_INFO_BPS")
f = File.open(file_name,'w')
f.close

#
sth = conn.execute("SELECT CD_BRAND FROM NNK_CORPORATE_INFO WHERE ACTIVE_FLG = '1'")
sth.fetch_hash do |row|

  cd_brand = row["CD_BRAND"]
  puts cd_brand
  search(cd_brand, file_name)

end
sth.finish

puts "end"

