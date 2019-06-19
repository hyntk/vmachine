# このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。

# 例

# irb
# require '/Users/apple/workspave/Ruby/jihanki.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）

# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new

# 作成した自動販売機に100円を入れる
# vm.slot_money (100)

# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money

# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @juice = [{price: 120,name: "コーラ",count: 5}]
    @sales_money = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    p @slot_money
  end

  def slot_juice
    p @juice
  end

  def purchase
    puts "自販機にある飲み物："
    for i in 0..@juice.length - 1 do
      puts @juice[i][:name]
    end
    puts "買いたい飲み物の名前入力してね"
    player = gets.chomp
    flag = 0
    
    for i in 0..@juice.length - 1 do
      if @slot_money >= @juice[i][:price] && @juice[i][:count] > 0 && @juice[i][:name] == player
        @juice[i][:count] -= 1
        @slot_money -= @juice[i][:price]
        @sales_money += @juice[i][:price]
        puts "#{player}。在庫#{@juice[i][:count]}、残高#{@slot_money}"
        flag = 1
        return_money
      end
    end
    if flag == 0
      puts "#{player}は買えませんでした〜＼(^o^)／"
    end
  end

  def sales_money
    p @sales_money
  end

  def purchase_true
    for i in 0..@juice.length - 1 do
      if @slot_money >= @juice[i][:price] && @juice[i][:count] > 0
        puts "#{@juice[i][:name]}は買えるで！^^"
      else
        puts "#{@juice[i][:name]}は金たらんくて買えへんわ！＼(^o^)／"
      end
    end
  end

  def redbull_add
    flag = 0
    for i in 0..@juice.length - 1 do
      if @juice[i][:name] == "レッドブル"
        puts "レッドブルはもうあるがな"
        flag = 1
        break
      end
    end
    if flag == 0
      @juice << {price: 200,name: "レッドブル",count: 5}
      puts "#{@juice.last}追加したで！"
    end
  end

  def water_add
    flag = 0
    for i in 0..@juice.length - 1 do
      if @juice[i][:name] == "水"
        puts "水はもうあるがな"
        flag = 1
        break
      end
    end
    if flag == 0
      @juice << {price: 100,name: "水",count: 5}
      puts "#{@juice.last}追加したで！"
    end
  end

  def add_juice
    puts "値段入力　数字"
    x = gets.to_i
    puts "品物入力　文字列"
    y = gets.chomp
    puts "個数入力 数字"
    z = gets.to_i

    flag = 0
    for i in 0..@juice.length - 1 do
      if @juice[i][:name] == y
        puts "#{y}はもうあるがな"
        flag = 1
        break
      end
    end
    if flag == 0
      @juice << {price: x,name: y,count: z}
      puts "#{@juice.last}追加したで！"
    end
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    unless MONEY.include?(money)
      p "#{money}円は自販機に使えないので返却される運命であった。"
      return false
    end
    # 自動販売機にお金を入れる
    @slot_money += money
    p "#{@slot_money}円、自販機に入っているよ"
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "#{@slot_money}円返却します"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
    puts "自販機の投入金額は#{@slot_money}円になりました"
  end
end

vm = VendingMachine.new
while true
  puts "----------------------------"
  puts "操作を選択して下さい"
  puts "0:お金を投入する"
  puts "1:自販機に入れたお金を確認する"
  puts "2:自販機のジュースの種類を確認する"
  puts "3:飲み物を買う"
  puts "4:自販機の売上を確認する"
  puts "5:今何の飲み物買える？"
  puts "6:お金を返却する"
  puts "7:レッドブル追加"
  puts "8:水追加"
  puts "9:好きな飲物を追加"
  puts "99:終了"
  puts "----------------------------"

  player = gets.to_i

  case player
  when 0
    puts "自販機に入れるお金の金額を入力して下さい"
    money = gets.to_i
    vm.slot_money (money)
  when 1
    vm.current_slot_money
  when 2
    vm.slot_juice
  when 3
    vm.purchase
  when 4
    vm.sales_money
  when 5
    vm.purchase_true
  when 6
    vm.return_money
  when 7
    vm.redbull_add
  when 8
    vm.water_add
  when 9
    vm.add_juice
  when 99
    break
  end

end