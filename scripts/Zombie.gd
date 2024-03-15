extends KinematicBody2D

export(int) var health = 100
export(int) var speed = 100
var player_pos
var target_pos
onready var player = get_parent().get_parent().get_node("Player")

enum elem {Norm, Fire, Water, Dust, Wind, Shock, Grass, Frost}
var appliedElem

var isAlive = true

signal reaction(pos, elem1, elem2)
signal death()

onready var affect = $ColorRect

func _ready():
	$Sprite.play("idle")
	add_to_group("zombie")

func die():
	set_physics_process(false)
	$Sprite.play("die")
	#$Sprite.z_index -= 1
	if self.get_parent().name == "zombieManager":
		self.get_parent().emit_signal("death")
	disable_collisions(self)
	isAlive	= false

func disable_collisions(node):
	# Disable collisions for the current node
	if node is CollisionObject2D:
		node.set_collision_layer_bit(0, false)
		node.set_collision_mask_bit(0, false)

	# Recursively disable collisions for all children
	for child in node.get_children():
		disable_collisions(child)

func _physics_process(delta):
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		$Sprite.play("walk")
		move_and_slide(target_pos * speed)

func set_element(elem):
	appliedElem = elem

func take_damage(dmg, elem):
	#print(elem)
	if appliedElem == null:
		set_element(elem)
	else:
		var react = elemental_react(elem)
		if react:
			dmg *= 1.5
	
	dmg *= elem[3]
	health -= dmg
	
	if health <= 0:
		die()
	else:
		$Sprite.play("damage")


func elemental_react(elem) -> bool:
	if elem != appliedElem:
		emit_signal("reaction", global_position, appliedElem, elem)
		return true
	return false


func _on_bodyHitbox_area_entered(area):
	if area.get_parent().is_in_group("bullet"):
		print("bodyshot")
		var bullet = area.get_parent()
		take_damage(25, bullet.element)


func _on_headHitbox_area_entered(area):
	if area.get_parent().is_in_group("bullet"):
		print("headshot")
		var bullet = area.get_parent()
		take_damage(75, bullet.element)


func _on_cleanup_timeout():
	queue_free()
