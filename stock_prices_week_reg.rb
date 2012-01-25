require 'dbi'
require 'kconv'
require 'connection_maker.rb'
require 'lookup_get.rb'


#株価登録（週足）クラス


class StockPricesWeekReg

  def regStockPricesWeek(conn)


    file_name = LookupGet.new.getLookup(conn,"FILE_NAME","STOCK_PRICES_WEEK")
    open(file_name) {|file|
      while l = file.gets
        line = l.split(',')

        String sql = SQLProperties::SQL_AM_STOCK_PRICE_UPDATE
        am_stock_price = (line[3].to_i + line[4].to_i) / 2
        para = am_stock_price ,line[0]

        print sql + "/パラメーター：" + para[0].to_s + "," + para[1] + "\n"
        conn.do(sql, para[0], para[1], SQLProperties::ACTIVE_FLG_ON)

      end
    }

    puts "end"
  end
end

