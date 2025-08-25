extends Node

var character
var spellmanager
var ui_manager

enum game_states
{
  MENUS,
  GAMEPLAY,
  CUTSCENE,
  PAUSE,
}
var game_state:game_states = game_states.GAMEPLAY

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.
