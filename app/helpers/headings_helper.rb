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

  def org_date(date, inactive: false)
    "#{inactive ? '[' : '<'}#{date.strftime('%Y-%m-%d %a %H:%M')}#{inactive ? ']' : '>'}"
  end

  def agenda_date(date)
    date.strftime("%A").ljust(9) + date.strftime(" %e %b %Y")
  end

  def deadline_scheduled_line(heading)
    string = ''
    string << "DEADLINE: #{org_date(heading.deadline)}" if heading.deadline
    string << ' ' if heading.deadline && heading.scheduled
    string << "SCHEDULED: #{org_date(heading.scheduled)}" if heading.scheduled
    string << ' ' if heading.dates? && heading.closed_at
    string << "CLOSED: #{org_date(heading.closed_at, inactive: true)}" if heading.closed_at
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
