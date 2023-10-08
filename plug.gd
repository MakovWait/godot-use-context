extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug("MikeSchulze/gdUnit4", {"commit": "3439939e03eeae60b69a417ed6a264c00326340d"})
	
#   optional editor deps
	plug("MakovWait/godot-expand-region", {"exclude": ["addons/gdUnit4"]})
	plug("MakovWait/godot-find-everywhere")
	plug("MakovWait/godot-previous-tab")
	plug("MakovWait/godot-script-tabs")
