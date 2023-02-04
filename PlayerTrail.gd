extends Line2D

export (int) var segmentLength = 8
export (bool) var activeRoot = true

var point = Vector2()
var counter = 0
	
func ready():
	set_as_toplevel(true)

func createSegment(p1:Vector2, p2:Vector2) -> CollisionShape2D:
	var collision = CollisionShape2D.new()
	collision.shape = SegmentShape2D.new()
	collision.shape.a = p1
	collision.shape.b = p2
	return collision
	
func updateCollider():
	var n = points.size()
	if n > 4:
		# need 2 or more points
		var s = createSegment(points[n-2],points[n-3])
		$StaticBody2D.add_child(s)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	point = get_parent().global_position
	if counter == segmentLength:
		add_point(point)
		updateCollider()
		counter = 0
	if activeRoot:
		counter += 1

func _on_Player_crash():
	counter = 0
	activeRoot = false
	var scene = get_parent().get_parent()
	get_parent().remove_child(self)
	scene.add_child(self)
