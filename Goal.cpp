#include "Goal.h"

Goal::Goal() {
  x = 0.0f;
  y = 0.0f;
}

Goal::Goal(float _x, float _y) {
  x = _x;
  y = _y;
}

float Goal::X() {
  return x;
}

float Goal::Y() {
  return y;
}
