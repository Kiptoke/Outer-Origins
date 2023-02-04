extends Node2D

var speed = 3
var scene = load("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(512, -100)

func spawn():
	var spawn_pos = Vector2(position.x, 10)
	var player = scene.instance()
	player.position = spawn_pos
	var level = get_parent()
	get_parent().remove_child(self)
	level.add_child(player)
	queue_free()
	print("spawn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_input():
	if Input.is_action_pressed("right") and position.x < 1005:
		position.x += speed
	if Input.is_action_pressed("left") and position.x > 20:
		position.x -= speed
	if Input.is_action_pressed("space"):
		spawn()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()
