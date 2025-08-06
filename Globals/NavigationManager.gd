extends Node

const SCENE_BEDROOM = preload("res://Scenes/WorldMap/PlayerHouse/1-bedroom.tscn")
const SCENE_LIVINROOM = preload("res://Scenes/WorldMap/PlayerHouse/2-living_room.tscn")

signal on_trigger_player_spawn(position: Vector2, direction: Vector2)

var spawn_door_tag

func go_to_level(level_tag: String, destination_tag: String):
  print(destination_tag)
  var  scene_to_load

  match level_tag:
    "1-bedroom":
      scene_to_load = SCENE_BEDROOM
    "2-living_room":
      scene_to_load = SCENE_LIVINROOM

  if scene_to_load != null:
    spawn_door_tag = destination_tag
    get_tree().change_scene_to_packed(scene_to_load)

func _on_trigger_player_spawn(position: Vector2, direction: Vector2):
  on_trigger_player_spawn.emit(position, direction)