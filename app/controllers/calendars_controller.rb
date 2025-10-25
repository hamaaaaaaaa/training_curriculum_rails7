class CalendarsController < ApplicationController
  # １週間のカレンダーと予定が表示されるページ
  def index
    load_week
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

  def load_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    @today_date = Date.today
    @week_days = []

    plans = Plan.where(date: @today_date..@today_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans << plan.plan if plan.date == @today_date + x
      end

      day_hash = {
        month: (@today_date + x).month,
        date:  (@today_date + x).day,
        plans: today_plans
      }

      @week_days << day_hash
    end
  end
end