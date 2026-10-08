extends Area2D
class_name Item

@export var description: String = ""

func _on_body_exited(player: Player) -> void:
	player.set_item(null)

func _on_body_entered(player: Player) -> void:
	player.set_item(self)
