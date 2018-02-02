module ApplicationHelper

  def flash_class(level)
    Rails.logger.debug(level)
    case level
      when "notice" then "alert alert-primary"
      when "success" then "alert alert-success"
      when "error" then "alert alert-danger"
      when "alert" then "alert alert-danger"

    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def page_title(title)
    @page_title=title
  end

  def eta_alla_data(data_nascita,data_sessione)
    year = data_sessione.year - data_nascita.year
    month = data_sessione.month - data_nascita.month
    day = data_sessione.day - data_nascita.day
    return year if (month > 0) or (month == 0 and day >= 0)
    return year - 1 if (month < 0) or (month == 0 and day < 0)
  end

  def recurrence_time(recurrence)
    if recurrence[0] == "{"
                          hash1=eval(recurrence)
                          times=hash1[:at]
                          return times.to_s.gsub("\"","").gsub(","," /").gsub("[","").gsub("]","")
    else
      return "*#{recurrence}" # if first character will be * it'll be treated as malformed string error
    end
  end
end
