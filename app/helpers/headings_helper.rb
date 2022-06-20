module HeadingsHelper
  SRC_BLOCK_REGEX = /#\+BEGIN_SRC([^\n]*)\n(.*?)#\+END_SRC/mo

  def depth_color(depth)
    "hsl(#{depth * 75 % 360}, 70%, 50%)"
  end

  def stars(depth)
    '*' * depth
  end

  def depth_spaces(depth, text)
    ' ' * (depth + 1) + text.gsub("\n", "\n#{' ' * (depth + 1)}")
  end

  def org_date(date)
    "<#{date.strftime('%Y-%m-%d %a %H:%M')}>"
  end

  def deadline_scheduled_line(heading)
    string = ''
    string << "DEADLINE: #{org_date(heading.deadline)}" if heading.deadline
    string << ' ' if heading.deadline && heading.scheduled
    string << "SCHEDULED: #{org_date(heading.scheduled)}" if heading.scheduled
    string
  end

  def process_org_body(text)
    return unless text

    escape_once(text).gsub(SRC_BLOCK_REGEX) do |_match|
      tag.code(Regexp.last_match(2))
    end.gsub(URI::DEFAULT_PARSER.make_regexp) do |match|
      tag.a(match, href: match)
    end
  end
end
