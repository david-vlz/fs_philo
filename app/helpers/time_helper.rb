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

  def number_of_days_from_now(dt)
    (dt.to_date - Date.today).to_i
  end

  def number_of_days_from_now_str(from_dt, until_dt)
    if happening_now?(from_dt, until_dt) then
      'Jetzt'
    else
      days = number_of_days_from_now(from_dt)
      if days > 1 then
        'In ' + days.to_s + ' Tagen'
      elsif days == 0 then
        'Heute'
      elsif days == 1 then
        'Morgen'
      end
    end
  end

  def happening_now?(from_dt, until_dt)
    now = DateTime.now
    until_dt = from_dt + 2.hours if not until_dt
    from_dt < now && now < until_dt
  end

  def same_day?(dt1, dt2)
    dt1.year == dt2.year && dt1.month == dt2.month && dt1.day == dt2.day
  end

end