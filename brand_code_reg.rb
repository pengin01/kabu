require 'dbi'
require 'kconv'
require 'lookup_get'
require 'sql/SQLProperties'


# 証券コード登録クラス
#ＣＳＶファイルを読み込みＩＮＳＥＲＴまたはＵＰＤＡＴＥ処理をする。


class BrandCodeReg
  def regBrandCode(conn)

    file_name = LookupGet.new.getLookup(conn,"FILE_NAME","BRAND_CODE")

    open(file_name) {|file|
      while l = file.gets
        line = l.split(',')

        para = line[0],line[1]

        sth = conn.execute(SQLProperties::BRAND_CODE_SELECT_SQL, para[0], SQLProperties::ACTIVE_FLG_ON)

        while row = sth.fetch do
          cnt = row["CNT_BRAND"]
        end
        sth.finish


          if(cnt == 0)

            String sql_2 = SQLProperties::CORPORATE_INFO_INSERT;

            print sql_2 + "/パラメーター：" + para[0] + "," + para[1] + "\n"

            conn.do(sql_2, para[0], para[1].tosjis, SQLProperties::ACTIVE_FLG_ON, "0")

          else

            String sql_3 = SQLProperties::CORPORATE_NM_CORPORATE_UPDATE

            print sql_3 + "/パラメーター：" + para[1] + "," + para[0] + "\n"

            conn.do(sql_3,para[1].tosjis, para[0], SQLProperties::ACTIVE_FLG_ON)

          end
      end
    }
    puts "end"
  end
end