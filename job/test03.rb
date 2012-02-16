require 'rubygems'
require 'kconv'
require 'hpricot'
require 'open-uri'
require 'filename_properties'

#会社情報取得(最低購入枚数)－ファイル出力

def search(num,file_name)

	under_stock = "0"
	f = File.open(file_name,'a')

	String url = "http://stocks.finance.yahoo.co.jp/stocks/profile/?code="
	doc = Hpricot(open(url + num))
	tmp = doc/"table.boardFinCom"
	tmp.each { |table| 
			(table/"td").each{|td|

				# 最低購入枚数 取得
				if (Kconv.toutf8(td.inner_text) =~ /[0-9]+株/ )
						under_stock = Kconv.toutf8(td.inner_text).gsub(/株/, "").gsub(/---/, "0")
						break
				end
		}
	}

	f.puts [num, under_stock].join(",")
	inserted = true
   f.close
end
brand_cd = "8008"
file_name = FILE_NAME::OUT_PATH + FILE_NAME::C_UNDER_STOCK + FILE_NAME::EXTENSIION

#ファイル出力
search(brand_cd, file_name)

puts "end"

