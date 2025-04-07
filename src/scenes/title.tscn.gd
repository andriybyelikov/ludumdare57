extends Node


func _ready() -> void:
    await SceneTransition.fade_in()


func _on_options_pressed() -> void:
    Options.show()
