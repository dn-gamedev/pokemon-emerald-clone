class_name DoorSystem extends Area2D

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_dir = 'down'

@onready var spawn: Marker2D = $Spawn

func _ready() -> void:
  body_entered.connect(_on_door_entered)

func _on_door_entered(body: Node2D):
  if body is Player:
    print('enter')
    pass