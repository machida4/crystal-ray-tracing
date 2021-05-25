require "./vec3"
require "./ray"
require "./hittable"

class RayTracing
  VERSION = "0.1.0"

  ASPECT_RATIO = 16.0 / 9.0
  IMAGE_WIDTH  = 400
  IMAGE_HEIGHT = (IMAGE_WIDTH / ASPECT_RATIO).to_i
  VIEWPORT_HEIGHT = 2.0
  VIEWPORT_WIDTH  = ASPECT_RATIO * VIEWPORT_HEIGHT
  FOCAL_LENGTH    = 1.0

  def self.main
    write_image(ARGV[0])
  end

  def self.ray_color(ray : Ray)
    sphere = Sphere.new(Point3.new(0, 0, -1), 0.5)
    hit?, hit_record = sphere.hit?(ray, ..Float64::INFINITY)
    if (hit?)
      return Color.new(1.0, 0.0, 0.0)
    end

    # レイの方向ベクトルを正規化
    unit_direction = ray.direction.unit_vector
    # 方向ベクトルのy成分を使って白と青を線形に混ぜ合わせレイの色とする
    t = 0.5 * (unit_direction.y + 1.0)
    Color.new(1.0, 1.0, 1.0) * (1.0 - t) + Color.new(0.5, 0.7, 1.0) * t
  end

  def self.write_image(filename : String)
    f = File.open(filename, "w")
    f.print("P3", "\n", IMAGE_WIDTH, " ", IMAGE_HEIGHT, "\n255\n")

    origin = Point3.new(0, 0, 0)
    horizontal = Vec3.new(VIEWPORT_WIDTH, 0, 0)
    vertical = Vec3.new(0, VIEWPORT_HEIGHT, 0)
    lower_left_corner = origin - horizontal/2 - vertical/2 - Vec3.new(0, 0, FOCAL_LENGTH)

    (IMAGE_HEIGHT - 1).downto(0) do |j|
      print_progression(j)
      0.upto(IMAGE_WIDTH - 1) do |i|
        u = i.to_f64 / (IMAGE_WIDTH - 1)
        v = j.to_f64 / (IMAGE_HEIGHT - 1)

        ray = Ray.new(origin, lower_left_corner + horizontal*u + vertical*v - origin)
        pixel_color = ray_color(ray)
        f.print(pixel_color.write_color)
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
