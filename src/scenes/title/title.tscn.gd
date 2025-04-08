extends Node


func _ready() -> void:
    await UIManager.ui_scale_changed


func _enter_tree() -> void:
    AudioManager.play_bgm(preload("res://assets/music/Lifted.mp3"))
    await SceneTransition.fade_in()


func _on_new_game_pressed() -> void:
    await SceneTransition.fade_out()
    self.get_tree().change_scene_to_file("res://src/scenes/main/main.tscn")


func _on_options_pressed() -> void:
    Options.show()


func _on_quit_pressed() -> void:
    self.get_tree().quit()
