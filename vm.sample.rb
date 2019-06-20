class VendingMachine

      # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze

  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
  end

  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

    def store_drink
        @stock_info = [{drink:"cola",price:120,stock:5},{drink:"redbull",price:120,stock:5},{drink:"water",price:100,stock:5}]
    end

    def purchase
        p "どの飲み物を買いますか？"
        p "0:cola"
        p "1:redbull"
        p "2:water"
        p @stock_info

        input = gets.chomp.to_i
        @selected_drink = @stock_info[input]
        p @selected_drink
        juice_stock=@selected_drink[:stock]
        juice_price=@selected_drink[:price]
        if juice_stock >= 1 && @slot_money >= juice_price
    #本数を1本減らす
        juice_stock = juice_stock - 1
        p juice_stock
    #配列に本数を書き戻す
        @stock_info[input][:stock]=juice_stock
        p @stock_info
    #お金の残高を減らす
        @slot_money = @slot_money - juice_price
        p @slot_money
        else
        return false
        end
    end

end    