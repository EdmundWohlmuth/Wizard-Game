extends Control

@onready var spell_list_panel = $Panel
@onready var spell_container = $Panel/SpellContainer

# Called when the node enters the scene tree for the first time.
func _ready():
  spell_list_panel.visible = false
  SignalBus.open_spellbook.connect(toggle_spelllist)
  
  for i in spell_container.get_child_count():
    if i <= GameManager.spellmanager.temp_spell_list.size() - 1:
      spell_container.get_child(i).text = get_spelllist_text(GameManager.spellmanager.temp_spell_list[i])
    else: 
      spell_container.get_child(i).visible = false

# fills the RichTextLables in the SpellContainer to be the current spell list
func get_spelllist_text(list) -> String:
  var text_to_return:String
  print(str(list.size()))
  
  for i in list.size():
    text_to_return += (list[i] + ", ")
      
  print(text_to_return)
  return text_to_return

func toggle_spelllist():
  if spell_list_panel.visible: spell_list_panel.visible = false
  else: spell_list_panel.visible = true
