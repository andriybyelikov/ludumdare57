extends Camera2D


const _BASE_ZOOM: int = 4
const _METER_PIXELS: int = 16
const _MIN_METERS_VISIBLE: int = 10
const _BASE_HEIGHT: int = _MIN_METERS_VISIBLE * _METER_PIXELS * _BASE_ZOOM


func _ready() -> void:
    self.get_tree().root.size_changed.connect(_on_root_window_size_changed)
    self._on_root_window_size_changed()


func _on_root_window_size_changed() -> void:
    var z: int = _BASE_ZOOM * self.get_tree().root.size.y / _BASE_HEIGHT
    self.zoom = Vector2(z, z)
