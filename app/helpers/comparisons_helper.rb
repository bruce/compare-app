module ComparisonsHelper

  attr_accessor :lines_to_style

  def format_code(input, html_options={})
    return nil if input.blank?
    content_tag(:dl, format_lines(input.split(/\r?\n/)).join, html_options)
  end
  
  def format_output(input, html_options={})
    return nil if input.blank?
    content_tag(:dl, format_lines(input.split(/\r?\n/), :errors => true).join, html_options)
  end
  
  def format_lines(lines, options={})
    output = []
    in_error = false
    lines.each_with_index do |line, offset|
      classes = ["line_#{offset + 1}"]
      if options[:errors] && line =~ /^-:(\d+):/
        in_error = true
        classes << "code_error code_error_line_#{$1}"
      end
      classes << 'error' if in_error
      output << content_tag(:dt, offset + 1) <<
                content_tag(:dd, line, :class => classes.join(' '))
      in_error = false if options[:errors] && in_error && line =~ /\^/
    end
    output
  end
  
  def show_output(text)
    if text.blank?
      content_tag(:td, 'No output', :class => :blank)
    else
      content_tag(:td, format_output(text))
    end
  end
    
end
