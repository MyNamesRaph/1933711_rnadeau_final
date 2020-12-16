extends KinematicBody2D

var speed = 200
var slowdownSpeed = 1
var velocity = Vector2()
export(PackedScene) var bullet
onready var bulletOut = $BulletOut

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var x = velocity.x
	var y = velocity.y
	if x > 0 :
		if slowdownSpeed < x :
			velocity.x -= slowdownSpeed
		else :
			velocity.x = 0
	if x < 0 :
		if slowdownSpeed < abs(x) :
			velocity.x += slowdownSpeed
			
	if y > 0 :
		if slowdownSpeed < y :
			velocity.y -= slowdownSpeed
		else :
			velocity.y = 0
	if y < 0 :
		if slowdownSpeed < abs(y) :
			velocity.y += slowdownSpeed

	get_input()
	
	var collision = move_and_collide(velocity*delta)


func get_input():
	var forward = Input.is_action_pressed("foward")
	var backward = Input.is_action_pressed("backward")
	var shoot = Input.is_action_just_pressed("attack")
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	
	var dir = get_global_mouse_position() - global_position
	rotation = dir.angle()
	
	var in_x = 0;
	var in_y = 0;
	
	if forward :
		in_x = in_x+speed
	if backward :
		in_x = in_x-speed
	if right :
		in_y = in_y + speed
	if left :
		in_y = in_y - speed
		
	if forward || backward || right || left :
		velocity = Vector2(in_x, in_y).rotated(rotation)
		
		
	if shoot :
		var b = bullet.instance()
		b.create(bulletOut.global_position, rotation)
		get_parent().add_child(b)
	
func hurt(damage):
	damage = float(damage)
	get_parent().hurtPlayer(damage)
