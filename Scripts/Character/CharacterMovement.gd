extends CharacterBody2D

const SPEED = 300.0

var can_control:bool = true
@onready var char_visual: AnimatedSprite2D = $CharVisual
var char_scale:float = 0.25

enum char_states
{
  STANDING,
  CROUCHING,
  WALKING,
  RUNING,
  EMOTING,
  SPELLBOOK,
  CASTING,
  DYING
}
var char_state:char_states = char_states.STANDING

func _ready():
  GameManager.character = self

func _physics_process(delta):
  # Get the input direction and handle the movement/deceleration.
  var direction_x = Input.get_axis("Right", "Left")
  var direction_y = Input.get_axis("Up", "Down")
  var is_moving:bool = false
  
  # left right movement
  if direction_x: 
    velocity.x = direction_x * SPEED
    is_moving = true 
  else: velocity.x = move_toward(velocity.x, 0, SPEED)
  
  # up down movement
  if direction_y: 
    velocity.y = direction_y * SPEED
    is_moving = true  
  else: velocity.y = move_toward(velocity.y, 0, SPEED)
  
  if !direction_x && !direction_y: 
    change_state(char_states.STANDING)
    is_moving = false
  
  animated_char_move()
      
  move_and_slide()

# handles character states
func change_state(new_state:char_states):
  match new_state:
    char_states.STANDING:
      char_visual.play("Standing")
    char_states.CROUCHING:
      pass
    char_states.WALKING:
      char_visual.play("Walking")
    char_states.RUNING:
      char_visual.play("Running")
    char_states.EMOTING:
      pass
    char_states.DYING:
      pass

#flips the character to be facing left or right and calls change state
func animated_char_move():
  if velocity.x > 0:
    char_visual.scale.x = char_scale
    if velocity.x >= 0.5: change_state(char_states.RUNING)
    else: change_state(char_states.WALKING)
        
  elif velocity.x < 0:
    char_visual.scale.x = -char_scale
    if velocity.x <= -0.5: change_state(char_states.RUNING)
    else: change_state(char_states.WALKING)
  
  elif velocity.y != 0:
    if velocity.y <= -0.5 || velocity.y > -0.5: change_state(char_states.RUNING)
    else: change_state(char_states.WALKING)
