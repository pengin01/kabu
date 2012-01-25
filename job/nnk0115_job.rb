require 'dbi'
require 'connection_maker.rb'
require 'brand_code_reg.rb'

#証券コードＤＢ登録ＪＯＢ

begin
  conn = ConectionMaker.new.getConnct()
  BrandCodeReg.new.regBrandCode(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e + "\n"
  conn.rollback
end
