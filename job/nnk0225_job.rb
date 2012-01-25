require 'dbi'
require 'connection_maker.rb'
require 'corporate_info_under_stock_reg.rb'

#会社情報登録ＪＯＢ(最低購入枚数)


begin
  conn = ConectionMaker.new.getConnct()
  CorporateInfoUnderStockReg.new.regCorporateInfoUnderStock(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e + "\n"
  conn.rollback
end
