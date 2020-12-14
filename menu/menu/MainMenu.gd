extends Control

const Game = preload("res://Game.gd")
const Instructions = preload("res://Instructions.tscn")

onready var gameList = $ItemList
onready var screenshot = $Preview/Screenshot
onready var title = $Preview/Title
onready var description = $Preview/Description

# var gamesPath = "/home/danielpeach/Arcade-Cabinet/games"
var gamesPath = "/Users/danielpeach/Godot/Arcade/Menu/games"
var games = []

func _ready():
	load_games(gamesPath)
	load_game_list()
	select_game(0)

func load_games(path):
	games.clear()
	gameList.clear()
	
	var dir = Directory.new()
	var file = File.new()
	var img = Image.new()
	var texture = ImageTexture.new()
	
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			var game = Game.new()
			var gamePath = path + "/" + file_name + "/"
			assert(file.open(gamePath + "metadata.json", file.READ) == OK)
			var text = file.get_as_text()
			var metadata = parse_json(text)
			assert(img.load(gamePath + metadata["logoPath"]) == OK)
			texture.create_from_image(img)
			game.screenshot = texture
			game.metadata = metadata
			games.append(game)
			file.close()
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access open the games directory. Check your path")

func load_game_list():
	for game in games:
		gameList.add_item(game.metadata["name"], game.screenshot)

func select_game(game_index):
	screenshot.texture = gameList.get_item_icon(game_index)
	title.text = gameList.get_item_text(game_index)
	description.text = games[game_index].metadata["description"]
	gameList.select(game_index)
	gameList.grab_focus()

func _on_ItemList_item_activated(index):
	var main = get_tree().current_scene
	var instructionsScene = Instructions.instance()
	instructionsScene.game = games[index]
	instructionsScene.gamePath = gamesPath + "/" + games[index].metadata["name"] + "/"
	main.add_child(instructionsScene)
	instructionsScene.set_global_position(Vector2(0, 0))
	
