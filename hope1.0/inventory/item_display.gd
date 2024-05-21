extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot : InvSlot):
	#(portiguês)Se não tiver nem um item,enão não irá aparecer
	#(inglês)
	if ! slot.item:
		item_visual.visible = false
		amount_text.visible = false
	#(portiguês)Mas se tiver, então irá aparecer
	#(inglês)
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)
