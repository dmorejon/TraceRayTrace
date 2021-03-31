using Mjolnir
using RayTrace

using RayTrace
import RayTrace: Sphere, Vec3, FancySphere
using Colors
using ImageView

"Some example spheres which should create actual image"
function example_spheres()
  scene = [FancySphere(Float64[0.0, -10004, -20], 10000.0, Float64[0.20, 0.20, 0.20], 0.0, 0.0, Float64[0.0, 0.0, 0.0]),
           FancySphere(Float64[0.0,      0, -20],     4.0, Float64[1.00, 0.32, 0.36], 1.0, 0.5, Float64[0.0, 0.0, 0.0]),
           FancySphere(Float64[5.0,     -1, -15],     2.0, Float64[0.90, 0.76, 0.46], 1.0, 0.0, Float64[0.0, 0.0, 0.0]),
           FancySphere(Float64[5.0,      0, -25],     3.0, Float64[0.65, 0.77, 0.97], 1.0, 0.0, Float64[0.0, 0.0, 0.0]),
           FancySphere(Float64[-5.5,      0, -15],    3.0, Float64[0.90, 0.90, 0.90], 1.0, 0.0, Float64[0.0, 0.0, 0.0]),
           # light (emission > 0)
           FancySphere(Float64[0.0,     20.0, -30],  3.0, Float64[0.00, 0.00, 0.00], 0.0, 0.0, Float64[3.0, 3.0, 3.0])]
  RayTrace.ListScene(scene)
end

function example_spheres2()
  scene = [
           FancySphere([0.0, 0.0, -20.0],     4.0, [1.00, 0.32, 0.36], 1.0, 0.5, [0.0, 0.0, 0.0]),
           # light (emission > 0)
           FancySphere([0.0,     20.0, -30.0],  3.0, [0.00, 0.00, 0.00], 0.0, 0.0, [3.0, 3.0, 3.0])
           ]
  RayTrace.ListScene(scene)
end

"Render an example scene and display it"
function render_example_spheres2()
  scene = example_spheres2()
  RayTrace.render(scene, trc = RayTrace.trcdepth)
end

"Render an example scene and display it"
function render_example_spheres()
  scene = example_spheres()
  RayTrace.render(scene)
end

function render_example_spheres_trcdepth()
  scene = example_spheres()
  RayTrace.render(scene, trc = RayTrace.trcdepth)
end

"Create an rgb image from a 3D matrix (w, h, c)"
function rgbimg(img)
  w = size(img)[1]
  h = size(img)[2]
  clrimg = Array{Colors.RGB}(undef, w, h)
  for i = 1:w
    for j = 1:h
      clrimg[i,j] = Colors.RGB(img[i,j,:]...)
    end
  end
  clrimg
end

function show_img()
  img_ = render_example_spheres()
  img = rgbimg(img_)
  println(maximum(img_))
  ImageView.imshow(img)
end

function show_img_depth()
  img_ = render_example_spheres_trcdepth()
  img_ = img_/maximum(img_)
  img = rgbimg(img_)
  println(maximum(img_))
  ImageView.imshow(img)
end

function show_img2_depth()
  img_ = render_example_spheres2()
  img = rgbimg(img_)
  ImageView.imshow(img)
end

tr = @trace render_example_spheres2()
println(tr)