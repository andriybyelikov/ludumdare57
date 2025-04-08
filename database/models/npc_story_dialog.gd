class_name NpcStoryDialog


var id: int
var npc_id: int
var story_flag_id: int
var route_flag_id: int
var dialog_text_id: int


func _to_string() -> String:
    return "(%d, %d, %d, %d, %d)" % [id, npc_id, story_flag_id, route_flag_id, dialog_text_id]
