# 此檔案可以將一文字檔單檔切成 Github Page 用的 Markdown 檔案，可方便直推Github BLOG 詳 https://jekyllrb.com/
# v1.0.1105
# TODO 重構，通用化，對不起它很髒XD
# 將此檔另存後執行 $ ruby spliter.rb 即將同資料夾內的 "-2016-11-05-.md" 切出下面格式檔案
# -2016-11-05-.md
# 事實
# 就是一切發生的事，眾人認同的事
# xxx
# 情感
# 就是你看一切的看法
#
# 檔案一.md
# ---
# layout: post
# comments: true
# title: 事實
# ---
# 就是一切發生的事，眾人認同的事
#
# 檔案二.md
# ---
# layout: post
# comments: true
# title: 情感
# ---
# 就是你看一切的看法

def chunker(f_in, out_pref)
  # 切檔記號
  splitter = 'xxx'

  File.open(f_in, 'r') do |fh_in|
    $title = ''
    filename = 1
    until fh_in.eof?
      unless File.exist?("#{out_pref}#{$title}#{filename}.md")
        File.open("#{out_pref}#{filename}.md", 'w+') do |fh_out|
          $title = fh_in.readline.chomp!
          File.rename("#{out_pref}#{filename}.md", "#{out_pref}#{$title}#{filename}.md")

          head = <<HEAD
---
layout: post
comments: true
title: #{$title}
---
HEAD
          fh_out << head
          puts '寫進head'
        end
      end
      # puts ">>打開#{filename}.md"
      # File https://www.tutorialspoint.com/ruby/ruby_input_output.htm
      File.open("#{out_pref}#{$title}#{filename}.md", 'a+') do |fh_out|
        line_context = fh_in.readline
        # puts '下一行'
        # 碰到splitter開新檔案
        if line_context == "#{splitter}\n"
          filename += 1
          # puts ">>換至#{filename}"
        else
          fh_out << line_context
          # puts ">>寫進#{line_context}"
        end
      end
    end
  end
end
today = Time.now.to_s.split(' ')[0]
# timenow = Time.now.to_s.split(' ')[1]
chunker 'yy.md', "#{today}-"

# TODO: 簡化 !!
# HACK 讀取第一行到標題 完成 只是要refacotring!@! 太醜了
# TODO: 模組化
# TODO title進檔名

# 年月日取得
# puts Time.now
# puts Time.now.to_s.class
# puts Time.now.to_s
# puts Time.now.to_s.split(' ')[0]

#
# arr = IO.readlines(f_in)
# puts arr
# arr.each do |i|
#   title = (arr[i + 1]).to_s if arr[i] == spliter.to_s
# end
