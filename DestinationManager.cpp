#include "DestinationManager.h"
#include <string>
#include <fstream>
#include <list>
#include <cstdlib>

DestinationManager::DestinationManager()
{
  std::ifstream infile("landmarks.txt");
  std::string line;
  
  while (std::getline(infile, line))
  {
    int pos = line.find(" ");
    std::string name = line.substr(0, pos);
    line = line.substr(pos + 1);
    
    pos = line.find(" ");
    std::string x = line.substr(0, pos);
    line = line.substr(pos + 1);
    
    pos = line.find(" ");    
    std::string y = line.substr(0, pos);
    
    Landmark lm(name, atof(x.c_str()), atof(y.c_str()));
    destinations.push_back(lm);
    names.push_back(name);
  }
  
  infile.close();
}

std::list<std::string> DestinationManager::GetNames()
{
  return names;
}

std::list<Landmark> DestinationManager::GetLandmarks()
{
  return destinations;
}
