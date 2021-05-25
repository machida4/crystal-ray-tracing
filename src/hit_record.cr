require "./vec3"

struct HitRecord
  getter point, front_face, normal, t

  def initialize(@point : Point3, @t : Float64)
    @front_face = false
    @normal = Vec3.new(0, 0, 0)
  end

  def self.plane
    HitRecord.new(Point3.new(0, 0, 0), 0)
  end

  def set_face_normal(ray : Ray, outward_normal : Vec3)
    @front_face = Vec3.dot(ray.direction, outward_normal) < 0
    @normal = @front_face ? outward_normal : -outward_normal
  end
end
