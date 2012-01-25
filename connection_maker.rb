require 'dbi'

class ConectionMaker
  def getConnct()

    conn = DBI.connect('DBI:ODBC:nanakusa_db', 'root', 'root')
    conn.tables
    conn['AutoCommit'] = false

    return conn

  end

  def commit(conn)

    conn.comit
    puts "コミットしました。"

  end
end
