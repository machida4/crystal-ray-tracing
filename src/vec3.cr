struct Vec3
  getter x, y, z

  def initialize
    initialize(0.0, 0.0, 0.0)
  end

  def initialize(
    @x : Float64,
    @y : Float64,
    @z : Float64
  )
  end

  # 単項演算子
  def -
    Vec3.new(-x, -y, -z)
  end

  # 二項演算子
  def +(other : self)
    Vec3.new(x + other.x, y + other.y, z + other.z)
  end

  def -(other : self)
    Vec3.new(x - other.x, y - other.y, z - other.z)
  end

  def *(t : Float64)
    Vec3.new(x * t, y * t, z * t)
  end

  def /(t : Float64)
    self * (1 / t)
  end

  def length
    sqrt(length_squared)
  end

  def length_squared
    x*x + y*y + z*z
  end

  # 内積
  def dot(other : self)
    x*other.x + y*other.y + z*other.z
  end

  # 外積
  def cross(other : self)
    Vec3.new(
      y*other.z - z*other.y,
      z*other.x - x*other.z,
      x*other.y - y*other.x
    )
  end

  def unit_vector
    self / self.length
  end

  def write_color
    "#{(255.999 * x).to_i.to_s} #{(255.999 * y).to_i.to_s} #{(255.999 * z).to_i.to_s}\n"
  end
end

alias Point3 = Vec3
alias Color = Vec3
