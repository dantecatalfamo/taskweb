module HeadingsHelper
  def self.create_markup_regex(character_regex)
    /#{MARKUP_BEGIN_REGEX}#{character_regex}(#{MARKUP_INTERNAL_REGEX})#{character_regex}#{MARKUP_END_REGEX}/
  end

  SRC_BLOCK_REGEX = /#\+BEGIN_SRC\s*([^\n]*)\n(.*?)#\+END_SRC/mi

  MARKUP_BEGIN_REGEX = /(?<=\s|\A)/
  MARKUP_INTERNAL_REGEX = /(?=\S).+?(?<=\S)/m
  MARKUP_END_REGEX = /(?=\s|\z)/
  BOLD_REGEX = create_markup_regex(/\*/)
  ITALIC_REGEX = create_markup_regex(%r{/})
  UNDERSCORE_REGEX = create_markup_regex(/_/)
  STRIKE_THROUGH_REGEX = create_markup_regex(/\+/)
  CODE_REGEX = create_markup_regex(/~/)
  VERBATIM_REGEX = create_markup_regex(/=/)
  UNCHECKED_BOX = "- [ ]"
  CHECKED_BOX = /- \[[xX]\]/
  LINK_REGEX = /\[\[(?<protocol>\w+):(?<link>[^\]]*)(\]\[(?<title>.*))?\]\]/


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

  def org_headline(heading)
    headline = stars(heading.depth)
    headline << " #{heading.state.name}" if heading.state
    headline << " #{heading.title}"
    headline
  end

  def org_dateline(heading)
    "#{depth_spaces(heading.depth, deadline_scheduled_line(heading))}"
  end

  def org_body(heading)
    "#{depth_spaces(heading.depth, heading.body).rstrip}"
  end

  def org_properties(heading)
    drawer = <<~EOF
    :PROPERTIES:
    :ID:       #{heading.org_id}
    :END:
    EOF
    depth_spaces(heading.depth, drawer)
  end

  def org_heading_render(heading)
    components = []
    components << "#{org_headline(heading)}"
    components << "#{org_dateline(heading)}" if heading.dateline?
    components << org_properties(heading)
    components << "#{org_body(heading)}" if heading.body.present?
    components.join("\n") + "\n"
  end

  def process_org_body(text)
    return unless text

    escape_once(text).gsub(SRC_BLOCK_REGEX) do
      tag.pre(class: 'border py-2 rounded bg-light') do
        tag.code(Regexp.last_match(2), class: ("language-#{Regexp.last_match(1)}" if Regexp.last_match(1).present?))
      end
    end.gsub(LINK_REGEX) do
      match = Regexp.last_match
      case match[:protocol]
      when /https?/
        link = match[:protocol] + ":" +  match[:link]
        title = match[:title] || link
        tag.a(title, href: link, data: { turbo_frame: "_top" })
      when /id/i
        title = match[:title] || link
        tag.a(title, href: heading_url(match[:link]), data: { turbo_frame: "_top" })
      end
    end.gsub(BOLD_REGEX) do
      tag.strong(Regexp.last_match(1))
    end.gsub(ITALIC_REGEX) do
      tag.em(Regexp.last_match(1))
    end.gsub(UNDERSCORE_REGEX) do
      tag.ins(Regexp.last_match(1))
    end.gsub(STRIKE_THROUGH_REGEX) do
      tag.del(Regexp.last_match(1))
    end.gsub(CODE_REGEX) do
      tag.code(Regexp.last_match(1), class: 'border border-danger px-1 bg-light rounded')
    end.gsub(VERBATIM_REGEX) do
      tag.samp(Regexp.last_match(1))
    end.gsub(UNCHECKED_BOX) do
      tag.input(type: :checkbox, disabled: true)
    end.gsub(CHECKED_BOX) do
      tag.input(type: :checkbox, checked: true, disabled: true)
    end
  end
end
