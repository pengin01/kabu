require 'dbi'
require 'kconv'
require 'lookup_get.rb'

#会社情報更新クラス（ＢＳＰ）


class CorporateInfoBspReg

  def regCorporateInfoBsp(conn)

    file_name = LookupGet.new.getLookup(conn,"FILE_NAME","CORPORATE_INFO_BPS")

    open(file_name) {|file|
      while l = file.gets
        line = l.split(',')

        String sql = SQLProperties::CORPORATE_NM_BPS_UPDATE;
        para = line[1],line[2],line[3],line[4],line[5],line[6],line[0]

        #暫定対応
        if(para[0] != "" && para[1] != "" && para[2] != "" && para[3] != "" && para[4] != "" && para[5] != "" && para[6] != "" )

          print sql + "/パラメーター：" + para[0] +  "," + para[1] + "," + para[2] + "," + para[3] + "," + para[4] + "," + para[5] + "," + para[6] + "\n"
          conn.do(sql, para[0], para[1], para[2], para[3], para[4], para[5], para[6], SQLProperties::ACTIVE_FLG_ON)

        else
          puts "error：" + para[6]
        end
      end
    }

    puts "end"
  end
end