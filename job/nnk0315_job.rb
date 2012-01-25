require 'dbi'
require 'connection_maker.rb'
require 'stock_prices_week_reg.rb'

#株価登録ｊｏｂ（週足）


begin
  conn = ConectionMaker.new.getConnct()
  StockPricesWeekReg.new.regStockPricesWeek(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e + "\n"
  conn.rollback
end
