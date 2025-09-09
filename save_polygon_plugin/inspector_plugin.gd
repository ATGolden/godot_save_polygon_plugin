extends EditorInspectorPlugin


var save_polygon_property = preload("res://addons/save_polygon_plugin/save_polygon_property.gd")


#If you only need it to handle specific nodes only, return true for those,
#Else return false for the rest
func _can_handle(object: Object) -> bool:
	
	return true


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	
	#Add plugin to each property that's named "polygon"
	if object is CollisionPolygon2D:
		if name == "polygon":
			add_custom_control(save_polygon_property.new())
	
	#Don't replace default property
	return false
