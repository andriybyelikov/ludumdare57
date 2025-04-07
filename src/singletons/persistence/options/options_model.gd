class_name OptionsModel


#region Video

var full_screen: bool
var windowed_resolution_id: int
var vertical_sync: bool

#endregion


func _init() -> void:
    self.full_screen = false
    self.windowed_resolution_id = 1
    self.vertical_sync = true
