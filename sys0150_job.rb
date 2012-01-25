require 'dbi'
require 'connection_maker.rb'
require 'opeday_get.rb'

#稼働日を翌日に更新


begin

  conn = ConectionMaker.new.getConnct()
  OpedayGet.new.next_ope(conn)
  conn.commit

  OpedayGet.new.get_ope(conn)
  puts "コミットしました。"



rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e + "\n"
  conn.rollback
end
