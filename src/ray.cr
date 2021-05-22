class Ray
  getter origin, direction

  def initialize(
    @origin : Point3,
    @direction : Vec3
  )
  end

  def at(t : Float64)
    @origin + t * @direction
  end
end
