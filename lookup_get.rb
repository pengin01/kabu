$LOAD_PATH << File.dirname(__FILE__)
require 'dbi'
require 'sql/SQLProperties'


#LOOKUP取得共通クラス

class LookupGet

  def getLookup(conn,lookup_type,lookup_name)

    String element_text = nil

    para = lookup_type, lookup_name

    sth = conn.execute(SQLProperties::SQL_LOOKUP_SELECT, para[0], para[1], SQLProperties::ACTIVE_FLG_ON)

    while row = sth.fetch do
      String element_text = row["ELEMENT_TEXT"]
    end
    sth.finish

    return element_text
  end
end
