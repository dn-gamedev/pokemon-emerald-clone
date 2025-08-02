extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var walk_speed = 4.0
const TILE_SIZE: int = 16
var initial_position = Vector2.ZERO
var input_direction = Vector2.ZERO
var is_moving: bool = false
var percent_moved_to_next_tile = 0.0

enum PlayerState {IDLE, TURNING, WALKING}
enum FacingDirection {UP, DOWN, LEFT, RIGHT}

var player_state = PlayerState.IDLE
var facing_direction = FacingDirection.DOWN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  initial_position = position
  pass # Replace with function body.

func _physics_process(delta: float) -> void:
  if player_state == PlayerState.TURNING:
    play_animation('turn', input_direction)
  elif is_moving == false:
    process_player_input()
  elif input_direction != Vector2.ZERO:
    move(delta)
    play_animation('walk', input_direction)
  else:
    is_moving = false

func process_player_input():
  if input_direction.y == 0:
    input_direction.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left')) 
  if input_direction.x == 0:
    input_direction.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))

  if input_direction != Vector2.ZERO:
    if need_to_turn():
      player_state = PlayerState.TURNING
      if input_direction == Vector2.LEFT:
        scale = Vector2(1, 1)
      elif input_direction == Vector2.RIGHT:
        scale = Vector2(-1, 1)
    else:
      player_state = PlayerState.WALKING
      initial_position = position
      is_moving = true
  else:
    is_moving = false
    animation_player.stop(true)
    play_animation('idle', input_direction)

func need_to_turn():
  var new_facing_direction
  if input_direction.x < 0:
    new_facing_direction = FacingDirection.LEFT
  elif input_direction.x > 0:
    new_facing_direction = FacingDirection.RIGHT
  elif input_direction.y > 0:
    new_facing_direction = FacingDirection.DOWN
  elif input_direction.y < 0:
    new_facing_direction = FacingDirection.UP

  if facing_direction != new_facing_direction:
    facing_direction = new_facing_direction
    return true  

  facing_direction = new_facing_direction
  return false

func finishing_turning():
  player_state = PlayerState.IDLE

func move(delta: float):
  percent_moved_to_next_tile += walk_speed * delta
  if percent_moved_to_next_tile >= 1.0:
    position = initial_position + (TILE_SIZE * input_direction)
    percent_moved_to_next_tile = 0.0
    is_moving = false
  else:
    position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)

func play_animation(animation: String, dir: Vector2):
  var anim = "%s-%s"
  if dir == Vector2.UP:
    animation_player.play(anim % [animation, "up"])
  if dir == Vector2.DOWN:
    animation_player.play(anim % [animation, "down"])
  if dir == Vector2.LEFT or dir == Vector2.RIGHT:
    animation_player.play(anim % [animation, "side"])
