/*
 * Project: Processing Cloud Renderer
 * Author:  Saman Sepehri Nejad
 * Date:    October 2026
 * Guide:   https://github.com/samansepehri/ProcessingCloudRenderer
 *
 * Description: An experimental journey to build a light cloud renderer in Processing.cpp
 * 
 */
 
const int sceneW = 720;
const int sceneH = 480;

void updatePixelsDensityAware()
{
  glPixelZoom(pixelWidth/width, pixelHeight/height);
  updatePixels();
  glPixelZoom(1.0f, 1.0f); // reset
}

float circleSDF(PVector p, PVector center, float r)
{
  return p.dist(center) <= r;
}

color paint(PVector p)
{
  PVector skyColor{102, 165, 242};
  PVector cloudColor{255, 255, 255};
  float cloudsShape = circleSDF(p, PVector{}, .1) + circleSDF(p, PVector{-.11, 0.}, .08) + circleSDF(p, PVector{.13, 0.}, .06);
  PVector result = skyColor + cloudColor * cloudsShape;
  
  return color{result.x, result.y, result.z};
}

void render()
{
  loadPixels();
  for(int y = 0; y < sceneH; ++y)
  {
      for(int x = 0; x < sceneW; ++x)
      {
        float u = (x - sceneW / 2.) / sceneH; // normalize by height
        float v = (y - sceneH / 2.) / sceneH; // -.5 to .5
        
        pixels[y*sceneW + x] = paint(PVector{u, v}); //color(255., 0., 0.);
      }
  }
  updatePixelsDensityAware();
}
void setup()
{
  // put your setup code here, to run once:
  size(sceneW, sceneH);
}

void draw()
{
  // put your main code here, to run repeatedly:
  render();
  noLoop();
}
