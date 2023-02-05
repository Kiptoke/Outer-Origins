extends Node2D

var metal = load("res://Scenes/Resources/Metallite.tscn")
var plant = load("res://Scenes/Resources/Nutrigen.tscn")
var comps = load("res://Scenes/Resources/Componentium.tscn")
var fuel = load("res://Scenes/Resources/Fuelline.tscn")
var lava = load("res://Scenes/Resources/Metallite.tscn") # TODO: create fuel texture
var rocks = load("res://Scenes/Rocks.tscn")

var ranges = {
	metal:[0,7500],
	plant:[0,5000],
	comps:[2500,5000],
	fuel:[5000,10000],
	lava:[7500,10000],
	rocks:[0,10000]
}

export (int) var metalVal = 2000
export (int) var plantVal = 2000
export (int) var compsVal = 1000
export (int) var fuelVal = 500
export (int) var rocksVal = 300
export (int) var rocksScaling = 5

func spawnResource(resource, mean:float, dev:float):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var x = rng.randi() % 1025
	var y = rng.randfn(mean,dev)
	while y < 0 or y > 10000:
		y = rng.randfn(mean,dev)
	var sp = resource.instance()
	if resource == rocks:
		sp.rotation = rng.randi() % 360
		sp.global_scale = Vector2(
			max(1, rng.randi() % rocksScaling), 
			max(1, rng.randi() % rocksScaling)
		)
	
	sp.position = Vector2(x,y)
	add_child(sp)
		
func levelInit():
	# Metallite generation
	for i in range(metalVal):
		spawnResource(metal,3000,2000)
	for i in range(plantVal):
		spawnResource(plant,0,1500)
	for i in range(compsVal):
		spawnResource(comps,5000,800)
	for i in range(fuelVal):
		spawnResource(fuel,10000,1500)
	for i in range(rocksVal):
		spawnResource(rocks,10000,3000)

# Called when the node enters the scene tree for the first time.
func _ready():
	levelInit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
