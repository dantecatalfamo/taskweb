class ResetAllHeadingsCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Heading.all.each do |heading|
      Heading.reset_counters(heading.id, :headings)
    end
  end

  def down
  end
end
