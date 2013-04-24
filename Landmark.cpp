#include "Landmark.h"
#include <sstream>

Landmark::Landmark()
{

}

Landmark::Landmark(std::string n, float _x, float _y) {
  name = n;
  x = _x;
  y = _y;
}

std::string Landmark::ToString() {
  std::stringstream sstm;
  sstm << name << ": (" << x << ", " << y << ")\n";
  return sstm.str();
}
