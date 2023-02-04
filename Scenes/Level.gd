extends Node2D

var metal = load("res://Scenes/Mineral.tscn")

func levelInit():
	var random = RandomNumberGenerator.new()
	random.randomize()
	for i in range(2000):
		var x = randi() % 1025
		var y = randi() % 10000
		var sp = metal.instance()
		sp.position = Vector2(x,y)
		add_child(sp)

# Called when the node enters the scene tree for the first time.
func _ready():
	levelInit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
