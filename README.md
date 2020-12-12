# CS Club Arcade Cabinet

This is the menu system that runs the arcade cabinet created by the CS Club at IUPUI. This menu system has seen many iterations, from python, to js, to c++, and (now) to Godot. 

## Content

* [Development]()
* [Installation]()
* [Everything else (Wiki)]()

### Why re-write it again in Godot?

While previous iterations have been built using *frameworks*, this time, we will use Godot, an open source full game-engine, editor, and community. The benefits of this are that we can avoid coding everything from input to graphics, and focus on polish and functionality. This iteration will be easier to install, build, and work on cross-platform. It will also look and work a lot better to our end users. After all, non-developers only care about looks!

## Architecture

The menu, through all its iterations has worked in a very similar mannar. The basic flow is: 

  * Have a collection of games, written with certain requirements for execution and metadata to work with our menu
  * Iterate through those games and display them in the menu using required image and metadata files
  * Have a standard for executing the game, in single player, two player, or player-count-agnostic ways
  * On game-exit, show the menu again for the user to pick another game

All other mechanics of leaderboards, menu systems, character creation, credits, etc, are up to the individual games and their developers.

^^^ move this stuff once the pages for them are set up
