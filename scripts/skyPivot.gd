extends Node2D

var rotation_speed = 0.01  # Adjust rotation speed as needed

func _process(delta):
	rotation += rotation_speed * delta
