require "./hittable"

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
    if (!t_range.covers?(temp_t))
      temp_t = (-half_b + root) / a
      if (!t_range.covers?(temp_t))
        return false, HitRecord.plane
      end
    end

    point = ray.at(temp_t)
    hit_record = HitRecord.new(point, temp_t)
    outward_normal = (point - center) / radius
    hit_record.set_face_normal(ray, outward_normal)

    return true, hit_record
  end
end
