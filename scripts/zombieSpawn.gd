extends Area2D

export (PackedScene) var zombie

onready var timer = $spawnTime
var minSpawnTime = 1.0
var maxSpawnTime = 5.0

var diff = 1

func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	# Start the timer
	timer.start()

func _on_Timer_timeout():
	for i in diff:
		spawnZombie()

func spawnZombie():
	# Randomize the spawn time
	var spawnTime = rand_range(minSpawnTime, maxSpawnTime)
	timer.wait_time = spawnTime

	# Create a new zombie instance
	var zombieInst = zombie.instance()
	
	# Set its position to a random point within the spawn area
	var spawnArea = $zombieArea.get_shape()
	var rectShape = spawnArea as RectangleShape2D
	
	# Get the position of the spawn area
	var spawnPosition = $zombieArea.global_position
	# Get the extents of the rectangle
	var rectExtents = rectShape.extents
	# Calculate the minimum and maximum points of the rectangle
	var rectMin = spawnPosition - rectExtents
	var rectMax = spawnPosition + rectExtents
	# Set the zombie's position to a random point within the rectangle
	var randomPosition = Vector2(rand_range(rectMin.x, rectMax.x), rand_range(rectMin.y, rectMax.y))
	
	# Set the position of the instantiated zombie node
	zombieInst.position = randomPosition

	# Add the zombie to the scene
	get_parent().get_parent().get_node("elements").get_node("zombieManager").add_child(zombieInst)



func _on_game_raiseDiff():
	diff += 1
