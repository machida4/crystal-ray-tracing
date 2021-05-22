require "./vec3"
require "./ray"

class RayTracing
  VERSION = "0.1.0"

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

        pixel_color = Color.new(r, g, b)
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
