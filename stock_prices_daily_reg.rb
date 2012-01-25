# simple.rb - Ruby DBI を使用した簡単なMySQLスクリプト

require 'dbi'
require 'kconv'
require 'lookup_get.rb'

#株価登録（日足）クラス


class StockPricesDailyReg

  def regStockPricesDaily(conn)


file_name = LookupGet.new.getLookup(conn,"FILE_NAME","STOCK_PRICES_DAILY")

    open(file_name) {|file|
      while l = file.gets
        line = l.split(',')

        String sql = SQLProperties::SQL_STOCK_PRICES_SERIES_DAILY_INSERT;

        d_sqe = line[1].split('-')

        if(d_sqe[1].split(//u).size != 2)
          mm = "0" + d_sqe[1]
        else
          mm = d_sqe[1]
        end

        if(d_sqe[2].split(//u).size != 2)
          dd = "0" + d_sqe[2]
        else
          dd = d_sqe[2]
        end

        cd_brand_sqe = d_sqe[0] + mm + dd

        para = line[0],cd_brand_sqe,line[1],line[2],line[3],line[4],line[5],line[6]

        #                //String count_sql = "SELECT COUNT(*) FROM CORPORATE_INFO WHERE CD_BRAND = '" + line[0] + "'"
        #                //puts count_sql
        #                row = conn.do(count_sql)
        #                puts row
        #                if(row == 0)
        print sql + "/パラメーター：" + para[0] + "," + para[1] + "," + para[2] + "," + para[3] + "," + para[4] + "," + para[5] + "," + para[6] + "," + para[7] + "\n"

        conn.do(sql, para[0], para[1], SQLProperties::ACTIVE_FLG_ON, para[2], para[3], para[4], para[5], para[6], para[7])
        #                 puts "comit"

      end
    }
    puts "end"
  end
end
