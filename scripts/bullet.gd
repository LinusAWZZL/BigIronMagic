extends KinematicBody2D

enum elem {Norm, Fire, Water, Dust, Wind, Shock, Grass, Frost}
var element = [0, true, "Norm", 1.0, 1.0, 242, 174, 87, 255]

var speed = 500
var velocity = Vector2()

onready var obj = $bulletColor

func _ready():
	#set_physics_process(false)
	#print(element)
	obj.color = Color(element[5], element[6], element[7])
	speed *= element[4]
	add_to_group("bullet")


func _physics_process(delta):
	velocity.x = speed
	move_and_slide(velocity)


func _on_bullet_area_entered(area):
	#print("Bullet hit %s" % area.get_parent())
	#print(area.get_groups())
	if area.get_parent().is_in_group("zombie"):
		queue_free()


func _on_lifetime_timeout():
	queue_free()
