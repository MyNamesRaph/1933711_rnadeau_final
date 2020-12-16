extends KinematicBody2D

export var speed = 0
var velocity = Vector2()
onready var texture = $Bullet
onready var timer = $Timer
var isDead = false
var fadeOut = 1.0
export var isPlayerBullet = false

func create(pos, dir) :
	position = pos
	velocity = Vector2(speed,0).rotated(dir)

func _process(delta):
	if isDead :
		fadeOut -= 0.2
	texture.modulate.a = fadeOut
	if fadeOut <= 0 :
		queue_free()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision :
		if isPlayerBullet :
			if collision.collider.is_in_group("enemy") :
				collision.collider.queue_free()
		queue_free()
			
func _on_Timer_timeout():
	isDead = true
