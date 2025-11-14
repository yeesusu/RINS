extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direcX = 1
var direcY = 1
var direction := Vector2.ZERO
var spd = 120
var hitAnim = false
@export var lutaMagoFogo = 0
var screen_size = Vector2.ZERO


func _ready() -> void:
	screen_size = get_viewport_rect().size
	add_to_group("Player")

func _physics_process(delta: float) -> void:
	if hitAnim:
		
		return
	# MOVIMENTO
	if Input.is_action_pressed("ui_up"): direcY = -1
	elif Input.is_action_pressed("UP"): direcY = -1
	elif Input.is_action_pressed("ui_down"): direcY = 1
	elif Input.is_action_pressed("DOWN"):direcY = 1
	else: direcY = 0
	if Input.is_action_pressed("ui_left"): direcX = -1
	elif Input.is_action_pressed("LEFT"):direcX = -1
	elif Input.is_action_pressed("ui_right"): direcX = 1
	elif Input.is_action_pressed("RIGHT"):direcX = 1
	else: direcX = 0
	velocity.x = 200 * direcX
	velocity.y = 200 * direcY
	
	if direcX == 1 :
		$AnimatedSprite2D.play("andandoDireita")
		$AnimatedSprite2D.flip_h = false
	elif direcX == -1:
		$AnimatedSprite2D.play("andandoDireita")
		$AnimatedSprite2D.flip_h = true
	elif direcX == 0 and direcY == 1:
		$AnimatedSprite2D.play("andandoFrente")
	elif direcX == 0 and direcY == -1:
		$AnimatedSprite2D.play("andandoTras")
	elif direcX == 0 and direcY == 0:
		$AnimatedSprite2D.play("idlefrente")
	# ATAQUE
	if Input.is_action_just_pressed("bater"):
		hitando_animation()
	move_and_slide()

	
	






func hit(area: Area2D) -> void:
	##trocador de cena
	print("batendo")
	if area == self:
		pass  
	if area.get_collision_layer_value(6):
		print("magofogo")
		lutaMagoFogo = 1
	if area.get_collision_layer_value(5):
		pass
	if area.get_collision_layer_value(4):
		pass
	if area.get_collision_layer_value(3):
		pass
	if area.get_collision_layer_value(2):
		get_tree().change_scene_to_file("res://Cena Luta/LutaFloresta.tscn")




func hitando_animation():
	hitAnim = true
	if direcX == 1:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("ataqueLado")
	elif direcX ==-1 :
		$AnimatedSprite2D.play("ataqueLado")
		$AnimatedSprite2D.flip_h = true
	elif direcY==1:
		$AnimatedSprite2D.play("ataqueFrente")
	elif direcX == 0 and direcY==0:
		$AnimatedSprite2D.play("ataqueFrente")
	elif direcY==-1:
		$AnimatedSprite2D.play("ataqueTras")
	if $Areahit.get_overlapping_areas().size()>0:
		hit($Areahit.get_overlapping_areas()[0])
	await $AnimatedSprite2D.animation_finished
	hitAnim = false
