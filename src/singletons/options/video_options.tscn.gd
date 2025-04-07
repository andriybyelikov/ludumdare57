extends Control


#region Persistent Model


var full_screen: bool
var windowed_resolution_id: int
var vertical_sync: bool


#endregion


#region Transient Model


var full_screen_resolution_id: int
var resolution_tree: Dictionary[int, Array]
var resolution_option_buttons: Dictionary[int, OptionButton]
var aspect_ratio_item_index: Dictionary[int, int]
var resolution_item_index: Dictionary[int, int]


#endregion


func _ready() -> void:
    self.full_screen = false
    self.windowed_resolution_id = 1
    self.vertical_sync = true
    
    self.full_screen_resolution_id = 0
    self.resolution_tree = {}
    
    self.resolution_option_buttons = {}
    for aspect_ratio: AspectRatio in DB.table("aspect_ratio").all():
        var option_button: OptionButton = OptionButton.new()
        option_button.item_selected.connect(_on_resolution_item_selected.bind(option_button))
        self.resolution_option_buttons[aspect_ratio.id] = option_button
    
    self.aspect_ratio_item_index = {}
    self.resolution_item_index = {}
    
    self._refresh_resolution_tree()
    
    %FullScreen.value = self.full_screen
    %FullScreen.value_selected.emit(self.full_screen)
    
    %VerticalSync.value = self.vertical_sync
    %VerticalSync.value_selected.emit(self.vertical_sync)
    
    await SceneTransition.fade_in()


func _apply_configuration() -> void:
    var window_mode: DisplayServer.WindowMode
    if self.full_screen:
        window_mode = DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
    else:
        window_mode = DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
    
    var vsync_mode: DisplayServer.VSyncMode
    if self.vertical_sync:
        vsync_mode = DisplayServer.VSyncMode.VSYNC_ENABLED
    else:
        vsync_mode = DisplayServer.VSyncMode.VSYNC_DISABLED
    
    
    DisplayServer.window_set_mode(window_mode)
    
    if window_mode == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
        var resolution: Resolution = DB.table("resolution").find(self.windowed_resolution_id)
        self.get_tree().root.size = Vector2i(resolution.width, resolution.height)
    
    DisplayServer.window_set_vsync_mode(vsync_mode)


#region Resolution Tree Computation


static \
func _get_resolution_tree() -> Dictionary[int, Array]:
    var result: Dictionary[int, Array] = {}
    
    var screen_size: Vector2i = DisplayServer.screen_get_size()
    for resolution: Resolution in DB.table("resolution").where(
        func (x: Resolution):
            return x.width <= screen_size.x and x.height <= screen_size.y
    ):
        var aspect_ratio_id: int = AspectRatio.classify(resolution)
        if aspect_ratio_id not in result:
            result[aspect_ratio_id] = []
        result[aspect_ratio_id].append(resolution.id)
    
    return result


static \
func _get_resolution_tree_diff(
    old: Dictionary[int, Array],
    new: Dictionary[int, Array]
) -> Dictionary:
    var add_keys: Array[int] = []
    var add_values: Dictionary[int, Array] = {}
    for aspect_ratio_id: int in new:
        if aspect_ratio_id in old:
            add_values[aspect_ratio_id] = []
            add_values[aspect_ratio_id].append_array(new[aspect_ratio_id].filter(
                func (resolution_id: int):
                    return resolution_id not in old[aspect_ratio_id]
            ))
        else:
            add_keys.append(aspect_ratio_id)
            add_values[aspect_ratio_id] = []
            add_values[aspect_ratio_id].append_array(new[aspect_ratio_id])
    
    var remove_keys: Array[int] = []
    var remove_values: Dictionary[int, Array] = {}
    for aspect_ratio_id: int in old:
        if aspect_ratio_id in new:
            remove_values[aspect_ratio_id] = []
            remove_values[aspect_ratio_id].append_array(old[aspect_ratio_id].filter(
                func (resolution_id: int):
                    return resolution_id not in new[aspect_ratio_id]
            ))
        else:
            remove_keys.append(aspect_ratio_id)
            remove_values[aspect_ratio_id] = []
            remove_values[aspect_ratio_id].append_array(old[aspect_ratio_id])
    
    return {
        "additions": {
            "keys": add_keys,
            "values": add_values,
        },
        "deletions": {
            "keys": remove_keys,
            "values": remove_values,
        },
    }


#endregion


#region UI Updates


func _apply_changes_to_resolution_tree_ui(changes: Dictionary):
    for aspect_ratio_id: int in changes["additions"]["keys"]:
        var aspect_ratio: AspectRatio = DB.table("aspect_ratio").find(aspect_ratio_id)
        self.aspect_ratio_item_index[aspect_ratio.id] = %AspectRatio.item_count
        %AspectRatio.add_item(aspect_ratio.label, aspect_ratio.id)
        %ResolutionByAspectRatio.add_child(self.resolution_option_buttons[aspect_ratio_id])
    
    for aspect_ratio_id: int in changes["additions"]["values"]:
        var option_button: OptionButton = self.resolution_option_buttons[aspect_ratio_id]
        for resolution_id: int in changes["additions"]["values"][aspect_ratio_id]:
            var resolution: Resolution = DB.table("resolution").find(resolution_id)
            var label: String = "%d×%d" % [resolution.width, resolution.height]
            self.resolution_item_index[resolution.id] = option_button.item_count
            option_button.add_item(label, resolution.id)
    
    for aspect_ratio_id: int in changes["deletions"]["keys"]:
        var index: int = self.aspect_ratio_item_index[aspect_ratio_id]
        %AspectRatio.remove_item(index)
        %ResolutionByAspectRatio.remove_child(self.resolution_option_buttons[aspect_ratio_id])
        self.aspect_ratio_item_index.erase(aspect_ratio_id)
    
    for aspect_ratio_id: int in changes["deletions"]["values"]:
        var option_button: OptionButton = self.resolution_option_buttons[aspect_ratio_id]
        for resolution_id: int in changes["deletions"]["values"][aspect_ratio_id]:
            var index: int = self.resolution_item_index[resolution_id]
            if option_button.selected == index:
                option_button.selected = 0
            option_button.remove_item(index)


func _refresh_resolution_tree() -> void:
    var old_resolution_tree: Dictionary[int, Array] = self.resolution_tree
    var new_resolution_tree: Dictionary[int, Array] = _get_resolution_tree()
    var resolution_tree_changes: Dictionary = _get_resolution_tree_diff(
        old_resolution_tree,
        new_resolution_tree
    )
    # TODO: Remove before release
    print("resolution_tree_changes: %s" % [resolution_tree_changes])
    self._apply_changes_to_resolution_tree_ui(resolution_tree_changes)
    self.resolution_tree = new_resolution_tree


func _select_resolution_in_ui(resolution_id: int):
    var resolution: Resolution = DB.table("resolution").find(resolution_id)
    var aspect_ratio_id: int = AspectRatio.classify(resolution)
    var resolution_option_button: OptionButton = self.resolution_option_buttons[aspect_ratio_id]
    
    %AspectRatio.selected = self.aspect_ratio_item_index[aspect_ratio_id]
    %ResolutionByAspectRatio.current_tab = %AspectRatio.selected
    resolution_option_button.selected = self.resolution_item_index[resolution_id]


#endregion


#region Signal Callbacks


func _on_full_screen_value_selected(value: bool) -> void:
    self.full_screen = value
    
    var resolution_id: int
    
    if self.full_screen:
        var screen_size: Vector2i = DisplayServer.screen_get_size()
        var result: Array[Object] = DB.table("resolution").where(
            func (x: Resolution):
                return x.width == screen_size.x and x.height == screen_size.y
        )
        
        if result.is_empty():
            var row: Resolution
            row = Resolution.new()
            row.width = screen_size.x
            row.height = screen_size.y
            self.full_screen_resolution_id = DB.table("resolution").insert(row)
            self._refresh_resolution_tree()
            resolution_id = self.full_screen_resolution_id
        else:
            resolution_id = (result[0] as Resolution).id
    else:
        if self.full_screen_resolution_id > 0:
            DB.table("resolution").delete(self.full_screen_resolution_id)
            self.full_screen_resolution_id = 0
            self._refresh_resolution_tree()
        resolution_id = self.windowed_resolution_id
    
    self._select_resolution_in_ui(resolution_id)
    
    var focus_mode: Control.FocusMode
    if self.full_screen:
        focus_mode = Control.FocusMode.FOCUS_NONE
    else:
        focus_mode = Control.FocusMode.FOCUS_ALL
    
    %AspectRatio.disabled = self.full_screen
    %AspectRatio.focus_mode = focus_mode
    for option_button: OptionButton in self.resolution_option_buttons.values():
        option_button.disabled = self.full_screen
        option_button.focus_mode = focus_mode
    
    self._apply_configuration()


func _on_aspect_ratio_item_selected(index: int) -> void:
    %ResolutionByAspectRatio.current_tab = index
    self._on_resolution_item_selected(0, %ResolutionByAspectRatio.get_tab_control(index))


func _on_resolution_item_selected(index: int, resolution_option_button: OptionButton) -> void:
    self.windowed_resolution_id = resolution_option_button.get_item_id(index)
    self._select_resolution_in_ui(self.windowed_resolution_id)
    self._apply_configuration()


func _on_vertical_sync_value_selected(value: bool) -> void:
    self.vertical_sync = value
    self._apply_configuration()


#endregion
