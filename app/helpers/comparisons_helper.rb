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
      classes << "first-line" if offset == 0
      if options[:errors] && line =~ /^-:(\d+):/
        in_error = true
        classes << "code_error code_error_line_#{$1}"
      end
      classes << 'error' if in_error
      output << content_tag(:dt, offset + 1) <<
                content_tag(:dd, h(line), :class => classes.join(' '))
      in_error = false if options[:errors] && in_error && line =~ /\^/
    end
    output
  end
  
  def show_output(text, html_options={})
    if text.blank?
      content_tag(:td, 'No output', :class => "#{html_options[:class]} blank")
    else
      content_tag(:td, format_output(text), html_options={})
    end
  end
  
  def benchmark_info_for(*results)
    options = results.last.is_a?(Hash) ? results.pop : {}
    results = results.sort_by(&:real_time)
    longest = results.last.real_time
    has_errors = results.any? { |r| !r.success? }
    content_tag(:ul,
      results.map { |r|
        if !options[:only] || options[:only].id == r.id
          if !r.success?
            content_tag(:span, "Error#{options[:only] ? '' : ' in ' + r.version}", :class => 'bad-result')
          else          
            percent = r.real_time / longest * 100
            content_tag(:li, "#{r.version unless options[:only]} <span class='time'>#{'%.8f' % r.real_time}s</span>",
              :class => (r.id == results.first.id ? 'winner' : 'loser'),
              :style => "width:#{percent}%;")
          end
        else
          nil
        end
      }.compact.join,
      :class => "bars bars-#{has_errors ? 'with-errors' : 'without-errors'}")
  end
    
end
