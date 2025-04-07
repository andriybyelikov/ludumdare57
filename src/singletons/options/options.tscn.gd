extends CanvasLayer


func _ready() -> void:
    self.visible = false


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        self.visible = false
