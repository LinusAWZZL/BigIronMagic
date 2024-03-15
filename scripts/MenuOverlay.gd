extends CanvasLayer

var lastScore = 0

onready var title = $Title
onready var score = $Score

signal score(score)

func _ready():
	pass


func _on_Score_readyRead():
	emit_signal("score", lastScore)


func _on_Restart_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/levels"+ str(get_tree().current_scene.name) + ".tscn")


func _on_Quit_pressed():
	get_tree().quit()
