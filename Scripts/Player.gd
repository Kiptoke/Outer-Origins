extends KinematicBody2D

export (int) var speed = 5
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0
var spawner = load("res://Scenes/PlayerSpawner.tscn")

signal crash

func get_input():
	rotation_dir = 0
	velocity = Vector2(0,-1)
	if Input.is_action_pressed("right"):
		rotation_dir += 1
		# velocity.x += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
		# velocity.x -= 1
	#if Input.is_action_pressed("down"):
	#	velocity.y += 1
	#if Input.is_action_pressed("up"):
	#	velocity.y -= 1
	velocity = velocity.normalized() * speed
	return velocity.rotated(rotation)

func boundsCheck():
	if position.x < 0 or position.x > 1025:
		tipCrash("bounds")
	elif position.y < 0:
		tipCrash("surface")
	elif position.y > 10000:
		tipCrash("lava")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var motion = get_input()
	rotation += rotation_dir * rotation_speed * delta
	var collision = move_and_collide(motion)
	boundsCheck()
	if collision:
		tipCrash(collision.collider.get_parent().name)
	
func tipCrash(collider:String):
	if collider == "bounds":
		print("Out of Bounds!")
	elif collider == "Line2D":
		print("Crashed with root!")
	elif collider == "surface":
		print("Surfaced!")
	elif collider == "laval":
		print("Dug too deep!")
	emit_signal("crash")
	var sp = spawner.instance()
	var level = get_parent()
	level.add_child(sp)
	queue_free()
