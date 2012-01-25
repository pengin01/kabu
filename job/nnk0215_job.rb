require 'dbi'
require 'connection_maker.rb'
require 'corporate_info_bsp_reg.rb'

#会社情報登録ＪＯＢ(BSP)


begin
  conn = ConectionMaker.new.getConnct()
  CorporateInfoBspReg.new.regCorporateInfoBsp(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e
  conn.rollback
end