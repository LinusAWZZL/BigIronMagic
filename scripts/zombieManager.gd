extends Node2D


signal death()

func _ready():
	pass


#func _on_game_clearZombies():
#	for child in get_children():
#		if !child.isAlive:
#			child.queue_free()


func _on_Zombie_death():
	emit_signal("death")
