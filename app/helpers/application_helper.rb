module ApplicationHelper
  def strfdate(datetime)
    datetime.strftime('%Y年%m月%d日')
  end
end
