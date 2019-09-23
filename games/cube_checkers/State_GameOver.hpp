#pragma once

#include <SFML/Graphics.hpp>

#include "State_Base.hpp"

struct SharedContext;

class State_GameOver : public State_Base {
public:
  std::string winnerString;
  State_GameOver(SharedContext & ctx);
  ~State_GameOver();

  void handleEvent(sf::Event e);
  void update();
  void render();
private:
  sf::Text startOverText;
  sf::Text winnerText;
  sf::Font font;
};
