extends Control

@onready var gameplay = $GameplayUI

# Called when the node enters the scene tree for the first time.
func _ready():
  GameManager.ui_manager = self

func enable_gameplay():
  gameplay.visible = true
