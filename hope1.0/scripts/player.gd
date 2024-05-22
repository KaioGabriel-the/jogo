extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

## Quantidade de pontos de vida.
var hp: int = 100;

@onready var healthBar = get_node("Healthbar")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation:AnimatedSprite2D = $Sprite
var inv:Inv = preload("res://inventory/inventy_player.tres")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var can_move = !Global.uiNode.visible
	# Handle jump.
	if can_move:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")

	if direction and can_move:
		velocity.x = direction * SPEED
		animation.play("run")
		if direction > 0:
			animation.flip_h = false
		elif direction < 0:
			animation.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	move_and_slide()
	
func player():
	pass

func collect(item):
	inv.insert(item)
	
## Função responsável por calcular o dano recebido.
func takeDamage(amount):
	healthBar._set_health(hp - amount)
	hp -= amount;
	if hp <= 0:
		hp = 0;	
		print("Morri.")
