extends CanvasLayer


func _ready() -> void:
    self.visible = false


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        self.visible = false


func _on_visibility_changed() -> void:
    var tab_bar: TabBar = $UI/TabContainer.get_tab_bar()
    tab_bar.grab_focus()
