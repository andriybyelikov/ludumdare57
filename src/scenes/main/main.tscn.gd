extends Node2D


func _ready() -> void:
    AudioManager.play_bgm(preload("res://assets/music/Overworld.mp3"))
    await SceneTransition.fade_in()


func _on_options_pressed() -> void:
    Options.show()


func _on_return_to_title_pressed() -> void:
    await SceneTransition.fade_out()
    self.get_tree().change_scene_to_file("res://src/scenes/title/title.tscn")


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        if not Options.visible:
            $SystemMenu.visible = not $SystemMenu.visible
