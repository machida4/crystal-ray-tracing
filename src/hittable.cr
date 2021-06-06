require "./vec3"
require "./ray"

abstract class Hittable
  abstract def hit?(ray : Ray, t_range : Range)
end
