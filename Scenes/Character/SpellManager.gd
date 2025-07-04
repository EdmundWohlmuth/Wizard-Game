extends Node2D

# tracks the keycodes for casting spells
@export var input_tracker:Array[String]

var temp_spell_list:Array[Array]

var input_track_size:int = 10
var is_casting:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
  GameManager.spellmanager = self
  
  temp_spell_list.append(["Up", "Up", "Right", "Left", "Down", "Down"])
  temp_spell_list.append(["Up", "Down", "Left", "Left", "Left"])
  temp_spell_list.append(["Up", "Up", "Up"])

# read player inputs  
func _input(event):
  # Swich between casting and not casting, as well as clearing the input tracker
  if Input.is_action_just_pressed("Casting"):
    if is_casting: stop_casting(false)
    else: start_casting()
    SignalBus.emit_signal("open_spellbook")
  
  if event.is_pressed() && is_casting:
    match event.as_text():
      "Up": 
        #print(event.as_text())
        input_tracker.append("Up")
      "Right": 
        #print(event.as_text())
        input_tracker.append("Right")
      "Down": 
        #print(event.as_text())
        input_tracker.append("Down")
      "Left": 
        #print(event.as_text())
        input_tracker.append("Left")
  
    if input_tracker.size() > 0: check_spells()

# check to see if inputs equal a spell and cast them if true
func check_spells():
  # iterate through all spellbook spells
  for x in temp_spell_list.size() - 1:
    for i in input_tracker.size():

      if i > temp_spell_list[x].size(): return
      elif check_same_spell(temp_spell_list[x], input_tracker):
        print("casting " + str(temp_spell_list[x]))
        SignalBus.emit_signal("open_spellbook")
        stop_casting(true)
    
func check_same_spell(array1:Array, array2:Array):
  if array1.size() != array2.size(): return false
  for item in array1:
    if !array2.has(item): return false
    if array1.count(item) != array2.count(item): return false
  return true

# enables the spell casting process  
func start_casting():
  is_casting = true
  print("Castin' Spells!")

# Handles input reset and if a spell is casted starts cast_spell() 
func stop_casting(has_casted:bool): 
  is_casting = false
  print(str(input_tracker))
  
  if has_casted: 
    print("Casted A Spell!")
  else:
    print("stopped casting")
    
  input_tracker.clear()
    
