#ifndef LANDMARK_H
#define LANDMARK_H


#include <string>

class Landmark {
  public:
    Landmark();
    Landmark(std::string, float, float);
    std::string ToString();
    std::string name;
    float x;
    float y;
};

#endif
