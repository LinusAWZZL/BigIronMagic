extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_to(target_pos):
	set_process(false)
	#Animate
	
	var move_dir = (target_pos - position).normalized()
	#$Tween.interpolate_property($Pivot, "position", -move_dir * 32, Vector2(), $AnimationPlayer.current_animation_length)
	#$Pivot/Sprite.position = position - target_pos
	position = target_pos
	
	#$Tween.start
	
	#yield($AnimationPlayer, "animation_finished")
	
	set_process(true)

func bump():
	set_process(false)
	#AnimationPlayer.play("bump")
	#yield($AnimationPlayer, "animation_finished")
	set_process(true)
