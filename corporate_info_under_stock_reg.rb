require 'dbi'
require 'kconv'
require 'lookup_get.rb'

#会社情報－最低購入枚数ＵＰＤＡＴＥクラス

class CorporateInfoUnderStockReg

  def regCorporateInfoUnderStock(conn)

    file_name = LookupGet.new.getLookup(conn,"FILE_NAME","CORPORATE_INFO_UNDER_STOCK")

    open(file_name) {|file|
      while l = file.gets
        line = l.split(',')

        String sql = "UPDATE NNK_CORPORATE_INFO SET LAST_UPDATE_DATE = NOW(), NUM_NUNDER_STOCK = ? WHERE CD_BRAND = ? AND ACTIVE_FLG = '1'";
        para = line[1], line[0]

        print sql + "/パラメーター：" + para[0] + "," + para[1] + "\n"
        conn.do(sql,para[0],para[1])

      end
    }

    puts "end"
  end
end