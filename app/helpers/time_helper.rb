# encoding: utf-8
module TimeHelper

  def pretty_datetime_range_str(from_dt, until_dt)
    complete_date_f = "%d.%m, %H:%M"
    str_1 = from_dt.strftime(complete_date_f)
    if not until_dt then
      str_2 = ''
    elsif same_day?(from_dt, until_dt) then
      str_2 = '-' + until_dt.strftime("%H:%M")
    else
      str_2 =  ' - ' + until_dt.strftime(complete_date_f)
    end
    str_1 + str_2
  end

  def same_day?(dt1, dt2)
    if dt1.year == dt2.year \
    && dt1.month == dt2.month \
    && dt1.day == dt2.day then
      true
    else
      false
    end
  end

end