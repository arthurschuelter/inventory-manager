extends Control
class_name PauseMenu

@onready var inventory: VBoxContainer = $MenuOptions/Inventory
@onready var sort_button: Button = $MenuOptions/InventoryButtons/SortButton

const item_node_scene = preload("uid://rywo6giv5ugu")
var item_id: int = 0

signal items_sorted

func _ready() -> void:
	self.visible = false
	sort_button.pressed.connect(SortInventory)

func SetVisible(_is_visible: bool) -> void:
	self.visible = _is_visible

func AddItem(item: Item):
	var item_node: ItemNode = item_node_scene.instantiate()
	item_node.name = "ItemNode_%d" % item_id
	item_id += 1
	inventory.add_child(item_node)
	item_node.item_label.text = item.description

func SortInventory() -> void:
	items_sorted.emit()
	var item_nodes: Array[String] = []
	for child in inventory.get_children():
		if child is ItemNode:
			item_nodes.append(child.item_label.text)
	
	item_nodes.sort_custom(func alphabet(a: String, b: String): return a < b)
	
	for child in inventory.get_children():
		if child is ItemNode:
			child.item_label.text = item_nodes.pop_front()
