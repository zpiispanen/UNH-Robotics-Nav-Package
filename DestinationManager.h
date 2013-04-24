#include "Landmark.h"
#include <list>
#include <string>

class DestinationManager
{
  public:
    DestinationManager();
    std::list<std::string> GetNames();
    std::list<Landmark> GetLandmarks();
    
  private:
    std::list<std::string> names;
    std::list<Landmark> destinations;
};
