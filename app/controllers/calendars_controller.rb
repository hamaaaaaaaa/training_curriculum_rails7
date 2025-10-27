class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    binding.pry  # ← ここで処理が止まり、paramsなどを確認できる
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  # フォームで送られてくるパラメータの指定
  def plan_params
    # フォームは model: @plan なので require(:plan) が正解
    params.require(:plan).permit(:date, :plan)
  end

  # 1週間分の日付・曜日・予定を取得するメソッド
  def getWeek
    wdays = ['(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)']

    @todays_date = Date.today
    @week_days = []

    # 今日から6日後までの予定を取得
    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today = @todays_date + x
      today_plans = []

      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == today
      end

      # 曜日を追加
      days = {
        month: today.month,
        date: today.day,
        wday: wdays[today.wday],  # ← 曜日を追加！
        plans: today_plans
      }

      @week_days.push(days)
    end
  end
end