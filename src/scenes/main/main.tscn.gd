extends Node2D


func _ready() -> void:
    Options.visibility_changed.connect(_on_options_visibility_changed)
    $SystemMenu.visibility_changed.connect(_on_system_menu_visibility_changed)
    AudioManager.play_bgm(preload("res://assets/music/Overworld.mp3"))
    await SceneTransition.fade_in()


func _on_options_pressed() -> void:
    Options.show()


func _on_return_to_title_pressed() -> void:
    await SceneTransition.fade_out()
    self.get_tree().change_scene_to_file("res://src/scenes/title/title.tscn")


func _input(event: InputEvent) -> void:
    if not Options.visible:
        if event.is_action_pressed("toggle_system_menu"):
            $SystemMenu.visible = not $SystemMenu.visible
        elif event.is_action_pressed("ui_cancel"):
            if $SystemMenu.visible:
                $SystemMenu.visible = false


func _on_options_visibility_changed() -> void:
    if not Options.visible:
        %Options.grab_focus()


func _on_system_menu_visibility_changed() -> void:
    %Player.set_physics_process(not $SystemMenu.visible)
    %Player.set_process_input(not $SystemMenu.visible)
    if $SystemMenu.visible:
        %Options.grab_focus()
