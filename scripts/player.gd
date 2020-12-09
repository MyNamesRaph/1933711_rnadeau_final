extends KinematicBody2D

onready var anim = $sprite
export var vitesse = 200
export var gravity = 1000
export var impulsion = -800
var jumping = false
var velocity = Vector2()
var lives = 3;

func _process(delta):
	_anim_player()

func _physics_process(delta):
	_ctrl_player()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0,-1))

func _anim_player():
	if Input.is_action_pressed("ui_right"):
		anim.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		anim.flip_h = true

func _ctrl_player():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_select")
	
	velocity.x = 0
	if right:
		velocity.x += vitesse
	if left:
		velocity.x -= vitesse
	if jump and is_on_floor():
		jumping = true
		velocity.y = impulsion

func _on_Area2D_body_entered(body):
	print("You Win!")
	get_parent().get_node("win").visible = true
	queue_free()
	
func hurt() :
	if lives > 0 :
		lives = lives-1;
		$Lives.text = "Vies: " + str(lives)
	else :
		get_parent().get_node("lose").visible = true
		queue_free();
