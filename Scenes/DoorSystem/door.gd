class_name Door extends Area2D

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_dir = Vector2.DOWN

@onready var spawn: Marker2D = $Spawn

func _ready() -> void:
  body_entered.connect(_on_door_entered)

func _on_door_entered(body: Node2D):
  if body is Player:
    print('enter')
    NavigationManager.go_to_level(destination_level_tag, destination_door_tag)