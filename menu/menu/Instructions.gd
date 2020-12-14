extends Control

var game
var gamePath 

onready var instructions = $InstructionsContainer

func _ready():
	var gameInstructions = game.metadata["instructions"]
	
	var curRow = 8
	for instruction in gameInstructions:
		curRow = generate_dynamic_instructions(instruction, curRow)
	

func generate_dynamic_instructions(gameInstructions, startRow = 8):
	var instructionsNodes = []
	while gameInstructions != "":
		var regexStartIndex = gameInstructions.find("{{")
		if regexStartIndex == -1:
			var finalInstructionLabel = Label.new()
			finalInstructionLabel.text = gameInstructions
			instructionsNodes.append(finalInstructionLabel)
			break
		var subStringInstruction = gameInstructions.substr(0, regexStartIndex)
		gameInstructions = gameInstructions.substr(regexStartIndex + 2)
		var staticInstructionLabel = Label.new()
		staticInstructionLabel.text = subStringInstruction
		instructionsNodes.append(staticInstructionLabel)
		var regexEndIndex = gameInstructions.find("}}")
		var dynamicInstruction = gameInstructions.substr(0, regexEndIndex)
		var dynamicInstructionTextureRect = TextureRect.new()
		dynamicInstructionTextureRect.texture = load("res://" + dynamicInstruction + ".png")
		instructionsNodes.append(dynamicInstructionTextureRect)
		gameInstructions = gameInstructions.substr(regexEndIndex + 2)
		
	var curCol = 8
	var curRow = startRow
	for node in instructionsNodes:
		instructions.add_child(node)
		node.rect_position = Vector2(curCol, curRow)
		node.rect_size.y = 75
		if node is Label:
			node.valign = Label.VALIGN_CENTER
		if node is TextureRect:
			node.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		var nextCol = curCol + node.rect_size.x
		if nextCol < get_viewport_rect().size.x - 16:
			curCol = nextCol
		else:
			curCol = 8 + 32
			curRow += 80
			node.rect_position = Vector2(curCol, curRow)
			curCol = node.rect_size.x
	
	return curRow + 80

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		if InputMap.event_is_action(event, "esc"):
			queue_free()
		if InputMap.event_is_action(event, "start1"):
			var startCmd = game.metadata["start1"].split(" ")
			var cmd = startCmd[0]
			var path = gamePath + startCmd[1]
			queue_free()
			OS.execute(cmd, [path])
		if InputMap.event_is_action(event, "start2"):
			var startCmd = game.metadata["start2"].split(" ")
			var cmd = startCmd[0]
			var path = gamePath + startCmd[1]
			queue_free()
			OS.execute(cmd, [path])
