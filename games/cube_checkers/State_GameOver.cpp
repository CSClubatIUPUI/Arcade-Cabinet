#include <iostream>

#include "State_GameOver.hpp"
#include "State_MainMenu.hpp"
#include "Game.hpp"

#define PADDING 50

State_GameOver::State_GameOver(SharedContext & ctx) : State_Base(ctx),
startOverText(), winnerText() {

  if (!font.loadFromFile("assets/font/Bold.ttf")) {
    std::cerr << "State_GameOver could not load font from file: assets/font/Bold.ttf" << std::endl;
    exit(1);
  }

  winnerText.setFont(font);
  winnerText.setCharacterSize(45);
  winnerText.setString("Player X wins!");
  winnerText.setOrigin(winnerText.getGlobalBounds().width / 2, winnerText.getGlobalBounds().height / 2);
  winnerText.setPosition(ctx.window.getSize().x / 2, ctx.window.getSize().y / 2 - 50);

  startOverText.setFont(font);
  startOverText.setFillColor(sf::Color::Black);
  startOverText.setCharacterSize(30);
  std::string startOverTextString = "Press any button to go back to Main Menu";
  startOverText.setString(startOverTextString);
  startOverText.setOrigin(startOverText.getGlobalBounds().width / 2, startOverText.getGlobalBounds().height / 2);
  startOverText.setPosition(ctx.window.getSize().x / 2, ctx.window.getSize().y / 2 + 50);
}

State_GameOver::~State_GameOver() {}

void State_GameOver::handleEvent(sf::Event e) {
  if (e.type == sf::Event::Closed) {
    ctx.window.close();
  } else if (e.type == sf::Event::KeyPressed) {
    switch (e.key.code) {
      case sf::Keyboard::Slash:
        ctx.window.close();
        break;
      default:
        ctx.stateMachine.pushState(std::make_unique<State_MainMenu>(ctx), true);
        break;
    }
  }
}

void State_GameOver::update() {}

void State_GameOver::render() {
  winnerText.setString(winnerString);
  ctx.window.clear(sf::Color(200, 15, 15));
  ctx.window.draw(winnerText);
  ctx.window.draw(startOverText);
}
