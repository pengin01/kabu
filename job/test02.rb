require 'rubygems'
require 'kconv'
require 'hpricot'
require 'open-uri'
require 'filename_properties'

#会社情報取得－ファイル出力ＪＯＢ

def search(num,file_name)


	f = File.open(file_name,'a')

	String url = "http://profile.yahoo.co.jp/independent/"
	bps = ""
	curr_profit = ""
	
	
	doc = Hpricot(open(url + num))
	tmp = doc/"table.yjMt"
	tmp.each { |table| 
		(table/"tr").each { |tr| 
			td = tr/"td"

			if(td.length > 3)
					
				# BPS（一株当たり純資産）取得
				if (Kconv.toutf8(td[0].inner_text) =~ /EPS（一株当たり利益）/ )
					bps = [td[1].inner_text, td[2].inner_text, td[3].inner_text].join(",")
					bps = Kconv.toutf8(bps).gsub(/円/, "")
				end
				
				# 当期利益 取得
				if (Kconv.toutf8(td[0].inner_text) =~ /当期利益/)
					curr_profit = [td[1].inner_text, td[2].inner_text, td[3].inner_text].join(",")
					curr_profit = Kconv.toutf8(curr_profit).gsub(/円/, "").gsub(/万/, "000").gsub(/千/, "0000").gsub(/百/, "00").gsub(/---/, "")	
				end
			end
		}
	}

	f.puts [num, bps, curr_profit].join(",")
	inserted = true
   f.close
end
brand_cd = "8008"
file_name = FILE_NAME::OUT_PATH + FILE_NAME::C_BPS + FILE_NAME::EXTENSIION
#ファイル出力
search(brand_cd, file_name)

puts "end"

7