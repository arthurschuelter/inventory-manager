extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory_manager: InventoryManager = $InventoryManager

const SPEED = 64.0
var last_input = Vector2.DOWN
var item: Item = null

var is_game_paused: bool = false

func _physics_process(delta: float) -> void:
	if is_game_paused:
		return
	
	var direction : Vector2 = Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	)
	
	if Input.is_action_just_pressed("space"):
		pickup()
	
	handle_movement(direction.normalized())
	handle_animation(direction)

func handle_movement(direction: Vector2) -> void:
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED
	move_and_slide()
	
	position.x = fmod(position.x, 320)
	if position.x < 0:
		position.x += 320 
		
	position.y = fmod(position.y, 180)
	if position.y < 0:
		position.y += 180 

func handle_animation(direction: Vector2) -> void:
	match direction:
		Vector2(1, 0):
			sprite.play("walk_right")
			last_input = Vector2(1, 0)
		Vector2(-1, 0):
			sprite.play("walk_left")
			last_input = Vector2(-1, 0)
		Vector2(0, -1), Vector2(1, -1), Vector2(-1, -1):
			sprite.play("walk_up")
			last_input = Vector2(0, -1)
		Vector2(0, 1), Vector2(1, 1),  Vector2(-1, 1):
			sprite.play("walk_down")
			last_input = Vector2(0, 1)
		Vector2(0, 0):
			match last_input:
				Vector2.UP:   	sprite.play("idle_up")
				Vector2.DOWN: 	sprite.play("idle_down")
				Vector2.RIGHT:	sprite.play("idle_right")
				Vector2.LEFT: 	sprite.play("idle_left")

func pickup() -> void:
	if item == null:
		print("There is nothing to pickup")
		return
	
	inventory_manager.Insert(item)

func set_item(_item: Item) -> void:
	self.item = _item
