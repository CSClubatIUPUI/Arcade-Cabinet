#pragma once

#include <SFML/Graphics.hpp>

#include "State_Base.hpp"

struct SharedContext;

class State_SplashScreen : public State_Base {
public:
  State_SplashScreen(SharedContext & ctx);
  ~State_SplashScreen();

  void handleEvent(sf::Event e);
  void update();
  void render();
private:
  sf::Text titleText;
  sf::Text introText;
  sf::Font font;
};
