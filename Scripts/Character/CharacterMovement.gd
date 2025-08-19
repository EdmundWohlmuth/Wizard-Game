extends CharacterBody2D

const SPEED = 300.0

var can_control:bool = true

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

func _physics_process(delta):
  # Get the input direction and handle the movement/deceleration.
  var direction_x = Input.get_axis("Right", "Left")
  var direction_y = Input.get_axis("Up", "Down")
  
  # left right movement
  if direction_x: velocity.x = direction_x * SPEED
  else: velocity.x = move_toward(velocity.x, 0, SPEED)
  # up down movement
  if direction_y: 
    velocity.y = direction_y * SPEED
    
  else: velocity.y = move_toward(velocity.y, 0, SPEED)

  move_and_slide()

func change_state(new_state:char_states):
  match new_state:
    char_states.STANDING:
      pass
    char_states.CROUCHING:
      pass
    char_states.WALKING:
      pass
    char_states.RUNING:
      pass
    char_states.EMOTING:
      pass
    char_states.DYING:
      pass

#flips the character to be facing left or right
func flip_char():
  pass
  
