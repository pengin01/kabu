require 'dbi'
require 'connection_maker.rb'
require 'fl_dealings_target_reg.rb'

#銘柄選定フラグ更新ＪＯＢ


begin
  conn = ConectionMaker.new.getConnct()
  FlDealingsTargetReg.new.regFlDealingsTarget(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e + "\n"
  conn.rollback
end
