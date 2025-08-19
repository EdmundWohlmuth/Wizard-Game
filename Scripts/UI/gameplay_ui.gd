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
  
  for i in list.size():
    text_to_return += (list[i] + ", ")
      
  return text_to_return

# enables and diables spelllist panel
func toggle_spelllist():
  if spell_list_panel.visible: spell_list_panel.visible = false
  else: 
    for x in spell_container.get_child_count():
      if x > GameManager.spellmanager.temp_spell_list.size() - 1: break
      spell_container.get_child(x).visible = true
    spell_list_panel.visible = true
 
# hides spells mid casting to inform player as to what can be cast 
func hide_spell(spell:int):
  spell_container.get_child(spell).visible = false

