extends CharacterBody2D


const _METER_PIXELS: int = 16
const _SPEED: float = 8


var _saved: Array[int]


var _talking: bool


var story_flag: int
var route_flag: int


func _enter_tree() -> void:
    self.story_flag = 1
    self.route_flag = 1
    self._saved = []


func _physics_process(delta: float) -> void:
    var l: float = Input.get_action_strength("move_left")
    var r: float = Input.get_action_strength("move_right")
    var direction: Vector2 = Vector2(r - l, 0)
    
    if direction.x > 0:
        $AnimatedSprite2D.flip_h = true
    elif direction.x < 0:
        $AnimatedSprite2D.flip_h = false
    
    if direction.length_squared() == 0:
        $AnimatedSprite2D.play(&"idle")
    else:
        $AnimatedSprite2D.play(&"walking")
    
    self.velocity = direction * _SPEED * _METER_PIXELS
    self.move_and_slide()


func _input(event: InputEvent) -> void:
    if not _talking:
        if Input.is_action_just_pressed("interact"):
            var overlapping_areas: Array[Area2D] = $Area2D.get_overlapping_areas()
            if overlapping_areas.size() > 0:
                var overlapping_area: Area2D = overlapping_areas[0]
                var npc: BaseNPC = overlapping_area.owner as BaseNPC
                
                #
                if npc.npc_id == 3:
                    self.route_flag = 2
                elif npc.npc_id == 6:
                    self.route_flag = 3
                #
                
                if self.route_flag == 2:
                    if npc.npc_id == 1:
                        if 1 not in self._saved:
                            self._saved.append(1)
                    elif npc.npc_id == 2:
                        if 2 not in self._saved:
                            self._saved.append(2)
                    elif npc.npc_id == 7:
                        if 7 not in self._saved:
                            self._saved.append(7)
                
                if npc.npc_id == 3 and 1 in self._saved and 2 in self._saved and 7 in self._saved:
                    self.route_flag = 4
                self._talking = true
                var npc_story_dialog: NpcStoryDialog = DB.table("npc_story_dialog").where(
                    func (x: NpcStoryDialog):
                        return (
                            x.npc_id == npc.npc_id and
                            x.story_flag_id == self.story_flag and
                            x.route_flag_id == self.route_flag
                        )
                )[0]
                await DialogManager.start_dialog(npc_story_dialog.dialog_text_id)
                self._talking = false
