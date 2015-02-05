module ApplicationHelper

  def body_css_class
    controller = controller_path.gsub("/","-").underscore.dasherize
    "#{controller}-body"
  end


end
