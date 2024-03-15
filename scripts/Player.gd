extends KinematicBody2D

export (int) var speed = 200
var velocity: Vector2 = Vector2()
var currentElement = elem.Norm
enum elem {Norm, Fire, Water, Dust, Wind, Shock, Grass, Frost}

var barrelPos: Vector2
var canShoot = true

signal shoot(pos, element)
signal lose()

# ElemInfo = [Id, unlocked, Name, damageMult, speedMult, R, G, B, A]
var unlockedElem = {
	elem.Norm:
		[0, true, "Norm", 1.0, 1.0, 242, 174, 87, 255],
	elem.Fire:
		[1, false, "Fire", 2.0, 1.0, 255, 0, 0, 255], 
	elem.Water:
		[2, false, "Water", 0.5, 1.0, 0, 0, 255, 255], 
	elem.Dust:
		[3, false, "Dust", 1.0, 0.5, 129, 64, 0, 255], 
	elem.Wind:
		[4, false, "Wind", 1.0, 2.0, 0, 255, 0, 255], 
	elem.Shock:
		[5, false, "Shock", 2.0, 2.0, 255, 0, 255, 255], 
	elem.Grass:
		[7, false, "Grass", 1.0, 1.0, 19, 97, 0, 255], 
	elem.Frost:
		[8, false, "Frost", 1.5, 1.5, 0, 255, 255, 255]
}


func _ready():
	pass


func get_input():
	var dir = Vector2()
	
	#print(global_position)
	
	if Input.is_action_pressed("move_up") and global_position.y > 400:
		dir.y -= 1
		
	if Input.is_action_pressed("move_down") and global_position.y < 560:
		dir.y += 1
	
	if Input.is_action_just_pressed("toggle_weapon"):
		print("Switch Element!")
		switch_element()
	
	if Input.is_action_just_pressed("shoot"):
		print("Shooting!")
		shoot()
	
	dir = dir.normalized()
	velocity = dir*speed


func unlock_element(ElemInfo, element):
	#print("Unlock elem %s %b" % element % ElemInfo[2])
	ElemInfo[1] = true
	unlockedElem[element] = ElemInfo


func get_next_element():
	var nextElement = currentElement + 1
	if nextElement > elem.Frost:
		nextElement = elem.Norm
	currentElement = nextElement
	return currentElement


func switch_element():
	currentElement = get_next_element()
	print(currentElement)
	


func _process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func shoot():
	if !canShoot:
		$fireRate.start()
	else:
		var element = unlockedElem[currentElement]
		#print(element)
		#print(element[1])
		if element[1]:
			#print(element[1])
			emit_signal("shoot", barrelPos, element)
		else:
			emit_signal("shoot", barrelPos, unlockedElem[elem.Norm])


func _on_bulletSpawnpoint_firePoint(pos):
	barrelPos = pos


func _on_fireRate_timeout():
	canShoot = true


func _on_Area2D_body_entered(body):
	#print(body.name)
	#print(body.get_parent().name)
	if body.get_parent().is_in_group("zombie"):
		emit_signal("lose")


func _on_Area2D_area_entered(area):
	#print(area.name)
	#print(area.get_parent().name)
	if area.get_parent().is_in_group("zombie"):
		emit_signal("lose")


func _on_game_unlockElement():
	print("New Element Unlock")
	var element = get_random_element()
	var ElemInfo = unlockedElem[element]
	while ElemInfo[1]:
		element = get_random_element()
		print(ElemInfo[1])
		unlockedElem[element]
	unlock_element(ElemInfo, element)

func get_random_element():
	var elements = [
		elem.Norm,
		elem.Fire,
		elem.Water,
		elem.Dust,
		elem.Wind,
		elem.Shock,
		elem.Grass,
		elem.Frost
	]
	
	var random_index = randi() % elements.size()
	return elements[random_index]
