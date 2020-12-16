extends Node

export(Array,PackedScene) var levels
export var defaultLevel = 0
var nextLevel
var currentLevel
export(PackedScene) var player
export(PackedScene) var playerHUD
var playerInstance
var playerHUDInstance
var isGameRunning = false
var maxPlayerHP = 100
var playerHP = maxPlayerHP

func _ready():
	playerInstance = player.instance()
	playerHUDInstance = playerHUD.instance()
	nextLevel = defaultLevel

func _process(delta):
	if isGameRunning :
		if currentLevel.get_node("Enemies").get_child_count() == 0:
			nextLvl()

#Start Game
func play():
	remove_child(get_node("Menu"))
	add_child(playerInstance)
	$HUD.add_child(playerHUDInstance)
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
	updateHUD()
#Advance to next level
func nextLvl():
	if nextLevel < len(levels) :
		remove_child(currentLevel)
		loadNext()
	else :
		playerHUDInstance.get_node("GameOver").show()
func updateHUD():
	playerHUDInstance.get_node("Text").text = "Health: "+str(playerHP)+"\nLevel: "+str(nextLevel)

func hurtPlayer(damagePercent):
	var damage = maxPlayerHP*(damagePercent/100)
	if playerHP > damage :
		print(damage)
		playerHP = playerHP - damage
	else :
		playerHP = 0
		playerInstance.queue_free()
		playerHUDInstance.get_node("GameOver").show()
	updateHUD()
