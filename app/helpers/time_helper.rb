# encoding: utf-8
module TimeHelper

  def pretty_datetime_range_str(from_dt, until_dt)

    complete_date_f = "%d.%m, %H:%M"

    return from_dt.strftime(complete_date_f) if not until_dt

    if from_dt.year == until_dt.year \
    && from_dt.month == until_dt.month \
    && from_dt.day == until_dt.day then
      from_dt.strftime(complete_date_f) + '-' + until_dt.strftime("%H:%M")
    else
      from_dt.strftime(complete_date_f) + ' - ' \
      + until_dt.strftime(complete_date_f)
    end

  end

end