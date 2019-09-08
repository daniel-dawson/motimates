module ApplicationHelper
  def flash_class_name(name)
    name == "alert" ? "ui error message" : "ui info message"
  end
end
