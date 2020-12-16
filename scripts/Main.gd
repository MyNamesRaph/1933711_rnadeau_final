extends Node

export(Array,PackedScene) var levels
export var defaultLevel = 0
var nextLevel = defaultLevel
var currentLevel
export(PackedScene) var player
var playerInstance
var isGameRunning = false

func _ready():
	playerInstance = player.instance()

func _process(delta):
	if isGameRunning :
		if currentLevel.get_node("Enemies").get_child_count() == 0:
			nextLvl()

#Start Game
func play():
	remove_child(get_node("Menu"))
	add_child(playerInstance)
	loadNext()
	isGameRunning = true

#Reset Game
func reset():
	get_tree().reload_current_scene()

#Quit Game
func quit():
	get_tree().quit()

#Load a level
func loadNext():
	currentLevel = levels[nextLevel].instance()
	add_child(currentLevel)
	nextLevel = nextLevel+1

#Advance to next level
func nextLvl():
	if nextLevel < len(levels)-1 :
		remove_child(currentLevel)
		loadNext()
	
