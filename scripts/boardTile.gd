extends Node2D
class_name boardTile

enum cell_types {ACTOR, obstacle, object}
var piece = {
	"exists": false,
	"piece": null
}

signal remove_piece()
signal add_piece()
signal affect_piece(element)

enum {
	normal,
	flame,
	water,
	storm
}

func _ready():
	pass # Replace with function body.

func get_position() -> Vector2:
	return position

func set_position(new_pos: Vector2) -> void:
	position = new_pos 

func remove_piece() -> void:
	piece["exists"] = false
	piece["piece"] = null
	
	emit_signal("remove_piece")

func set_piece(piece) -> void:
	piece["exists"] = true
	piece["piece"] = piece
	
	emit_signal("add_piece")

func randomize_element():
	pass

func elemental_affect() -> void:
	emit_signal("affect_piece", "element")
