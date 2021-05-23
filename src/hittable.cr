require "./ray.cr"

struct HitRecord
  getter point, normal, t, is_hit 

  def self.plane
    HitRecord.new(Point3.new(0, 0, 0), Vec3.new(0, 0, 0), 0)
  end

  def initialize(@point : Point3, @normal : Vec3, @t : Float64)
  end

end

abstract class Hittable
  getter center, radius

  abstract def hit?(ray : Ray, t_range : Range)
end

class Sphere < Hittable
  def initialize(@center : Point3, @radius : Float64)
  end

  def hit?(ray : Ray, t_range : Range) : {Bool, HitRecord}
    # 二次方程式の解の個数で衝突判定
    oc = ray.origin - center
    a = ray.direction.length_squared
    half_b = oc.dot(ray.direction)
    c = oc.length_squared - radius*radius
    # 判別式
    discriminant = half_b*half_b - a*c

    if (discriminant < 0)
      return false, HitRecord.plane
    end

    # 解が存在する場合は解がt_rangeの範囲内かチェックする
    root = Math.sqrt(discriminant)

    temp_t = (-half_b - root) / a
    if (t_range.covers?(temp_t))
      point = ray.at(temp_t)
      normal = (point - center) / radius
      return true, HitRecord.new(point, normal, temp_t)
    end

    temp_t = (-half_b + root) / a
    if (t_range.covers?(temp_t))
      point = ray.at(temp_t)
      normal = (point - center) / radius
      return true, HitRecord.new(point, normal, temp_t)
    end

    return false, HitRecord.plane
  end
end
