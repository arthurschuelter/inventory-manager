extends Node2D

var is_paused: bool = false
@onready var player: Player = $Player
@onready var pause_menu: PauseMenu = $UI/PauseMenu

func _ready():
	player.inventory_manager.item_inserted.connect(on_item_collected)
	pause_menu.items_sorted.connect(on_items_sorted)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	handle_pause()

func handle_pause() -> void:
	if Input.is_action_just_pressed("pause"):
		is_paused = not is_paused
		player.is_game_paused = is_paused
		pause_menu.SetVisible(is_paused)

func on_item_collected(item: Item) -> void:
	pause_menu.AddItem(item)

func on_items_sorted() -> void:
	player.inventory_manager.SortInventory()
