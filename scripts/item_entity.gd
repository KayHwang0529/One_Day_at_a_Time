@tool
class_name ItemEntity extends PandoraEntity

func get_item_name() -> String:
	return get_string("name")
	
func get_description() -> String:
	return get_string("description")

func get_texture() -> Texture:
	return get_resource("texture")
