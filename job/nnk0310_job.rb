require 'net/http'
require 'rubygems'
require 'kconv'
require 'hpricot'
require 'dbi'
require 'connection_maker.rb'
require 'opeday_get.rb'
require 'lookup_get.rb'

#株価情報取得（週足）-ファイル出力ＪＯＢ

  def search(cd_brand,file_name, ope_day)


    year = ope_day[0..3].to_i.to_s
    month = ope_day[4..5].to_i.to_s
    day = ope_day[6..7].to_i.to_s

    url = "c=" + year + "&a=" + month + "&b=" + day + "&f=" + year + "&d=" + month + "&e=" + day + "&g=w&s=" + cd_brand + "&y=0&z=" + cd_brand

    Net::HTTP.version_1_2
    Net::HTTP.start("table.yahoo.co.jp", 80) {|http|

      response = http.post('/t', url )

      doc = Hpricot(response.body)

      foo = File.open(file_name,'a')
      tmp = doc/"table[@cellpadding='5']"
      tmp.each { |table|
       (table/"tr").each { |tr|
          tds = tr/"td"

          if ( tds.length > 4 && tds[0].inner_text.toutf8 =~ /(\d+)年(\d+)月(\d+)日/ )
            foo.puts [cd_brand, tds[0].inner_text.toutf8.gsub(/年/, "-").gsub(/月/, "-").gsub(/日/, ""), tds[1].inner_text, tds[4].inner_text,
            tds[2].inner_text, tds[3].inner_text, tds[5].inner_text].join(" ").gsub(/,/, "").gsub(/ /, ",")
            inserted = true
          end
        }
      }

      foo.close
    }
  end

        conn = ConectionMaker.new.getConnct()
        ope_day = OpedayGet.new.get_ope(conn)
        file_name = LookupGet.new.getLookup(conn,"FILE_NAME","STOCK_PRICES_WEEK")

        f = File.open(file_name,'w')
        f.close


        sth = conn.execute("SELECT CD_BRAND FROM NNK_CORPORATE_INFO WHERE ACTIVE_FLG = '1'")
        sth.fetch_hash do |row|

          cd_brand = row["CD_BRAND"]
          puts cd_brand
          search(cd_brand, file_name, ope_day)

        end
        sth.finish

      puts "end"

