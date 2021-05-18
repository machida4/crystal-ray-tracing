# TODO: Write documentation for `Crystal::Ray::Tracing`
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
  end
end

RayTracing.main
