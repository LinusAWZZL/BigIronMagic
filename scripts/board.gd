extends TileMap
class_name board

enum cell_types { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}
export (int) var width := 16
export (int) var height := 3

var board_size = Vector2(width, height)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
	#populate_board()

func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		cell_types.EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		cell_types.OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		cell_types.ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, cell_types.EMPTY)
	return map_to_world(cell_target) + cell_size / 2


#func populate_board() -> void:
#	for x in range(board_size.x):
#		for y in range(board_size.y):
#			var new_tile = load("res://scenes/objects/boardTile.tscn").instance()
#			add_child(new_tile)
#			new_tile.set_position(Vector2(x, y) * 64)

#func isTileEmpty(pos, dir: Vector2):
#	var loc = world_to_map(pos) 

#func movePiece(target_pos):
#	pass
