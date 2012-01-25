require 'dbi'

#稼働日取得共通クラス

class OpedayGet


  def get_ope(conn)

    String dt_day = nil

    sth = conn.execute(SQLProperties::SQL_DT_DMY_OPERATING_DAY_SELECT)
    sth.fetch_hash do |row|

      String dt_dmy_ope_day = row["DT_DMY_OPERATING_DAY"].to_s
      dt_day = dt_dmy_ope_day[0..10].gsub('-','')
      puts dt_day

    end
    sth.finish

    return dt_day
  end

  def next_ope(conn)

    conn.do(SQLProperties::SQL_DT_DMY_OPERATING_DAY_UPDATE)

  end
end

