extends Node2D

export (PackedScene) var bullet

enum elem {Norm, Fire, Water, Dust, Wind, Shock, Grass, Frost}

func _ready():
	pass


func _on_Player_shoot(pos, element):
	var bulletInst = bullet.instance()
	
	#print(element)
	
	bulletInst.position = pos
	bulletInst.element = element
	
	add_child(bulletInst)
	
	bulletInst.add_to_group("bullets")
	
