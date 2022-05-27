module HeadingsHelper
  def depth_color(depth)
    return "hsl(#{depth * 75 % 360}, 70%, 50%)"
  end
end
