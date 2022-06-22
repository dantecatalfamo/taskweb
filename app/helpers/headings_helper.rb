module HeadingsHelper
  def self.create_markup_regex(character_regex)
    /#{MARKUP_BEGIN_REGEX}#{character_regex}(#{MARKUP_INTERNAL_REGEX})#{character_regex}#{MARKUP_END_REGEX}/
  end

  SRC_BLOCK_REGEX = /#\+BEGIN_SRC\s*([^\n]*)\n(.*?)#\+END_SRC/m

  MARKUP_BEGIN_REGEX = /(?<=\s|\A)/
  MARKUP_INTERNAL_REGEX = /(?=\S).+?(?<=\S)/m
  MARKUP_END_REGEX = /(?=\s|\z)/
  BOLD_REGEX = create_markup_regex(/\*/)
  ITALIC_REGEX = create_markup_regex(%r{/})
  UNDERSCORE_REGEX = create_markup_regex(/_/)
  STRIKE_THROUGH_REGEX = create_markup_regex(/\+/)
  CODE_REGEX = create_markup_regex(/~/)
  VERBATIM_REGEX = create_markup_regex(/=/)

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
    date.strftime('%A').ljust(9) + date.strftime(' %e %b %Y')
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

    escape_once(text).gsub(SRC_BLOCK_REGEX) do
      tag.pre do
        tag.code(Regexp.last_match(2), class: ("language-#{Regexp.last_match(1)}" if Regexp.last_match(1).present?))
      end
    end.gsub(URI::DEFAULT_PARSER.make_regexp) do |match|
      tag.a(match, href: match)
    end.gsub(BOLD_REGEX) do
      tag.strong(Regexp.last_match(1))
    end.gsub(ITALIC_REGEX) do
      tag.em(Regexp.last_match(1))
    end.gsub(UNDERSCORE_REGEX) do
      tag.ins(Regexp.last_match(1))
    end.gsub(STRIKE_THROUGH_REGEX) do
      tag.del(Regexp.last_match(1))
    end.gsub(CODE_REGEX) do
      tag.code(Regexp.last_match(1))
    end.gsub(VERBATIM_REGEX) do
      tag.samp(Regexp.last_match(1))
    end
  end
end
