require "./vec3"

struct HitRecord
  getter point, normal, t, is_hit 

  def self.plane
    HitRecord.new(Point3.new(0, 0, 0), Vec3.new(0, 0, 0), 0)
  end

  def initialize(@point : Point3, @normal : Vec3, @t : Float64)
  end
end
