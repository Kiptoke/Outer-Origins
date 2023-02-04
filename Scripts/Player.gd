extends KinematicBody2D

export (int) var speed = 5
export (float) var rotation_speed = 1.5

var velocity = Vector2()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		rotation_dir += 1
		# velocity.x += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
		# velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	return velocity.rotated(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var motion = get_input()
	rotation += rotation_dir * rotation_speed * delta
	move_and_collide(motion)
