class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end

#       曜日を追加したい
# 配列を使って表示したい（if文）
# 添字を使って表示する。
# Date.today.wday という自動的に曜日の数値を取得する　＋加算したい
# X＝　はtimesメソッドのブロック変数｜x｜
# wday_numは、曜日の添字を抽出する式



       wday_num = Date.today.wday + x
       # wdayメソッドを用いて取得した数値
      if wday_num >= 7
        wday_num = wday_num -7
        # もしwday_numが７より大きい場合、−７をするという条件式
       end
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, plans: today_plans, wday: wdays[wday_num]}
      @week_days.push(days)
    end

  end
end
