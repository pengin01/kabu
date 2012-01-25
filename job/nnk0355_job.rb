require 'dbi'
require 'connection_maker.rb'
require 'stock_prices_daily_reg.rb'

#株価登録ｊｏｂ（日足）


begin
  conn = ConectionMaker.new.getConnct()
  StockPricesDailyReg.new.regStockPricesDaily(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e
  conn.rollback
end
