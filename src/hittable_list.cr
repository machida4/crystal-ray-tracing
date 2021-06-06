require "./hittable"
require "./ray"
require "./hit_record"

class HittableList < Hittable
  getter list

  def initialize(@list : Array(Hittable))
  end

  def initialize
    @list = [] of Hittable
  end

  def clear
    @list = [] of Hittable
  end

  def add(object : Hittable)
    @list.push(object)
  end

  def hit?(ray : Ray, t_range : Range) : {Bool, HitRecord}
    record = HitRecord.plane
    hit_anything = false
    closest_so_far = t_range.end

    @list.each do |object|
      # TODO: beginやendがあるとは限らない
      is_hit, temp_record = object.hit?(ray, (t_range.begin .. closest_so_far))
      if (is_hit)
        hit_anything = true
        closest_so_far = temp_record.t
        record = temp_record
      end
    end

    return hit_anything, record
  end
end
