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
                content_tag(:dd, h(line), :class => classes.join(' '))
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
  
  def benchmark_info_for(comparison)
    if (errors = comparison.results.select { |r| !r.success? }).any?
      return content_tag(:span, "Error in #{errors.map(&:version).to_sentence}", :class => 'bad-result')
    end
    results = comparison.results.sort_by(&:real_time)
    longest = results.last.real_time
    content_tag(:ul,
      results.map { |r|
        percent = r.real_time / longest * 100
        content_tag(:li, "#{r.version} <span class='time'>#{'%.8f' % r.real_time}s</span>",
          :class => (r.id == results.first.id ? 'winner' : 'loser'),
          :style => "width:#{percent}%;")
      }.join,
      :class => 'bars')
  end
    
end
