require 'csv'

CSV.generate do |csv|
  column_names = %w(日付 曜日 勤務開始時間 勤務終了時間 )
  csv << column_names
  @attendances.each do |a|
    column_values = [
      l(a.worked_on, format: :short),
      $week[a.worked_on.wday],
      a.started_at.try(:strftime, "%H:%M"),
      a.finished_at.try(:strftime, "%H:%M")
    ]
    csv << column_values
  end
end