extends Node2D

var score = 0
var diff = 0
var is_paused = false

var menu_scene = preload("res://scenes/ui/MenuOverlay.tscn")

signal raiseDiff()
signal unlockElement()
signal clearZombies()

func _ready():
	pass

#func _ready():
# Show the menu when the game starts
#   show_menu()

func show_menu():
	# Load the menu scene and add it to the scene tree
	var menu_instance = menu_scene.instance()
	menu_instance.lastScore = score
	add_child(menu_instance)
	

func _on_Player_lose():
	print("Game Over!")
	print(score)
	show_menu()
	is_paused = true
	get_tree().paused = is_paused


func _on_zombieManager_death():
	score += 100
	if score > 1000 * diff:
		print("raising diff")
		diff += 1
		emit_signal("raiseDiff")
		emit_signal("unlockElement")
		emit_signal("clearZombies")
