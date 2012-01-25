# -*- coding: utf-8 -*-
require 'rubygems'
require("mechanize")

agent = Mechanize.new
#nkfopt = '-s -m0'
page = agent.get("http://www.4628.jp/") # ログインフォームのある URI
#form = page.form("form1") # ログイン情報 (ユーザ名とかパスワード) を入力させるフォームの名前
#                              # <form name="****"> の部分を入力．
#form.field_with(:name => "y_logincd").value = "NWI3198" # ユーザ名
#form.field_with(:name => "password").value = "pengin01" # パスワード (簡単のため平文で)
form = page.forms.first
form.fields[1].value  = "NWI3198"
form.fields[2].value  = "pengin001"
page2 = form.click_button
#page2 =  agent.submit(form)                       # NAME1 等には <input name="****"> の部分を入力．
# form.submit() かもしれない．何かここは色々複雑．

page = agent.get("http://www.4628.jp/needswell/?module=timesheet&action=browse") # ログインした状態で無ければ見えないページの URI

#page.body.serch
puts page2.title
puts page2.body
