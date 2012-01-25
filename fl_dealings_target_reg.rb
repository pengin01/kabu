require 'dbi'
require 'kconv'

class FlDealingsTargetReg

  def regFlDealingsTarget(conn)


    String sql_1 = "UPDATE NNK_CORPORATE_INFO SET FL_DEALINGS_TARGET = '0' WHERE ACTIVE_FLG = '1'";
    String sql_2 = "UPDATE NNK_CORPORATE_INFO SET LAST_UPDATE_DATE = NOW(), FL_DEALINGS_TARGET = '1' WHERE AM_STOCK_PRICE is not null AND AM_BPS_FIRST_TERM > (AM_STOCK_PRICE + 100) AND AM_PROFIT_CURRENT_FIRST_TERM >= 0 AND AM_STOCK_PRICE * NUM_NUNDER_STOCK < 50000 AND ACTIVE_FLG = '1'";
    conn.do(sql_1)
    a = conn.do(sql_2)
    puts a

    puts "end"
  end
end