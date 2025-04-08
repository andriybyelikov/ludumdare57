extends Label


func _ready() -> void:
    var size_label: Label = self.get_parent() as Label
    size_label.minimum_size_changed.connect(_on_size_label_minimum_size_changed)


func _on_size_label_minimum_size_changed() -> void:
    var size_label: Label = self.get_parent() as Label
    self.custom_minimum_size = size_label.get_minimum_size()
