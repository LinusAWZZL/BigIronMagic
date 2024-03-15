extends Node2D

signal firePoint(pos)


func _ready():
	pass

func _process(delta):
	emit_signal("firePoint", global_position)
