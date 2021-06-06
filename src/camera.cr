require "./vec3"
require "./ray"

class Camera
  ASPECT_RATIO    = 16.0 / 9.0
  VIEWPORT_HEIGHT = 2.0
  VIEWPORT_WIDTH  = ASPECT_RATIO * VIEWPORT_HEIGHT
  FOCAL_LENGTH    = 1.0

  def initialize(
    @origin : Point3,
    @horizontal : Vec3,
    @vertical : Vec3,
    @lower_left_corner : Vec3
  )
  end

  def initialize
    @origin = Point3.new(0, 0, 0)
    @horizontal = Vec3.new(VIEWPORT_WIDTH, 0, 0)
    @vertical = Vec3.new(0, VIEWPORT_HEIGHT, 0)
    @lower_left_corner = origin - horizontal/2 - vertical/2 - Vec3.new(0, 0, FOCAL_LENGTH)
  end

  def get_ray(u : Float64, v : Float64)
    return Ray.new(@origin, @lower_left_corner + @horizontal*u + @vertical*v - @origin)
  end
end
