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
  return p.dist(center) - r;
}

float circleSDFN(PVector p, PVector center, float r)
{
  return -circleSDF(p, center, r) / r;
}

float cloudsVolume(PVector p)
{
  float cloudsSDF = max(circleSDFN(p, PVector{}, .1), max(circleSDFN(p, PVector{-.11, 0.}, .08), circleSDFN(p, PVector{.13, 0.}, .06)));
  cloudsSDF = MH::saturate((cloudsSDF + 2.5) * .2);
  
  float noiseScale;
  
  // High frequency details
  noiseScale = 2;
  noiseDetail(4, 0.2);
  PVector hfP = p - PVector{5., 5., 5.};
  float hfClouds = noise(hfP.x * noiseScale, hfP.y * noiseScale, hfP.z * noiseScale);
  
  // Low frequency details
  noiseScale = 10;
  noiseDetail(8, 0.4);
  PVector lfP = p + PVector{200., 200., 200.};
  float lfClouds = noise(lfP.x * noiseScale, lfP.y * noiseScale, lfP.z * noiseScale);
  
  return MH::saturate((hfClouds - .8) * .6 + (lfClouds - .2) * .4 + cloudsSDF * .75);
}
PVector skyColor(PVector p)
{
  PVector skyColorBase{102, 165, 242};
  PVector skyColorSecondary{200, 200, 250};

  return -(-0.5 + p.y) * skyColorSecondary + (.5 + p.y) * skyColorBase;
}
color paint(PVector p)
{
  PVector cloudColor{255, 255, 255};
  PVector result = skyColor(p) + cloudColor * cloudsVolume(p);
  
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
