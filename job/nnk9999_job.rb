require 'dbi'
require 'connection_maker.rb'
require 'test_reg.rb'

begin
  conn = ConectionMaker.new.getConnct()
  TestReg.new.regTest(conn)
  conn.commit

rescue => e
  #Exceptionをthrowするやり方がわからん
  puts "error_rollback"
  puts e
  conn.rollback
end
