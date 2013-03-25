module ApplicationHelper
  def secure_form_for(record_or_name_or_array, *args, &block)
    options = args.extract_options!
    form_for(record_or_name_or_array, *(args << options.merge(builder: SecureFormBuilder)), &block)
  end
end
class SecureFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    super #@template.label(@object_name, method, text, objectify_options(options), &block)
  end
end