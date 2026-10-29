
namespace MH
{
float saturate(float val)
{
  return max(.0, min(1., val));
}
}
