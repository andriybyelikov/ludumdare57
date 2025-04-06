class_name EnabledOptionButton
extends OptionButton


signal value_selected(value: bool)


var value: bool:
    get:
        return self.selected as bool
    set(value):
        self.selected = value as int


func _init() -> void:
    self.add_item("Disabled")
    self.add_item("Enabled")
    self.item_selected.connect(_on_item_selected)


func _on_item_selected(index: int) -> void:
    self.value_selected.emit(index as bool)
