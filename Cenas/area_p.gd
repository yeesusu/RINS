extends Area2D

@export_file("*.tscn") var target_scene: String = "res://bioma_praia.tscn"  
@export var required_tag: String = "Player"  

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Cenas/bioma_praia.tscn")
