extends KinematicBody2D

var speed = 100
var velocity = Vector2()
export(PackedScene) var bullet
onready var bulletOut = $BulletOut
onready var timer = $Timer
var shooting = false;

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	shooting = false;
	var playerpos = get_parent().get_parent().get_parent().get_node("player").position - global_position
	rotation = playerpos.angle()
	
	var distance = sqrt(pow((position.x - playerpos.x),2) + pow((position.y - playerpos.y),2))
		
	if distance < 1500 : 
		
		shooting = true
		if distance > 300 :
			velocity = Vector2(speed, 0).rotated(rotation)
		else :
			velocity = Vector2(0, 0)
		
		
	var collision = move_and_collide(velocity*delta)
	
func _on_Timer_timeout():
	if shooting :
		var b = bullet.instance()
		b.create(bulletOut.global_position, rotation)
		get_parent().add_child(b)
		b.rotation = rotation+90
