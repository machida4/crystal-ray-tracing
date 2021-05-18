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

  alias Point3 = Vec3
  alias Color = Vec3
end

class RayTracing
  VERSION = "0.1.0"

  # TODO: Put your code here

  IMAGE_WIDTH  = 256
  IMAGE_HEIGHT = 256

  def self.main
    write_image(ARGV[0])
  end

  def self.write_image(filename : String)
    f = File.open(filename, "w")
    f.print("P3", "\n", IMAGE_WIDTH, " ", IMAGE_HEIGHT, "\n255\n")

    (IMAGE_WIDTH - 1).downto(0) do |j|
      print_progression(j)
      0.upto(IMAGE_HEIGHT - 1) do |i|
        r = i / (IMAGE_WIDTH - 1)
        g = j / (IMAGE_HEIGHT - 1)
        b = 0.25

        ir = (255.999 * r).to_i
        ig = (255.999 * g).to_i
        ib = (255.999 * b).to_i

        f.print(ir, " ", ig, " ", ib, "\n")
      end
    end

    f.close
    print "\n", "Done.", "\n"
  end

  def self.print_progression(remaining : Int)
    print "\r", "Scanlines remaining: ", remaining
    STDOUT.flush
  end
end

RayTracing.main
