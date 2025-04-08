extends CanvasLayer


signal dialog_finished


const _DELAY_TICKS_PERIOD: int = 2


var _dialog_text_id: int

var _delay_ticks_count: int


func _ready() -> void:
    self.visible = false


func _input(event: InputEvent) -> void:
    if self.visible:
        if event.is_action_pressed("interact"):
            if self._dialog_text_id > 0:
                if %ContentLabel.visible_characters == %ContentLabel.text.length():
                    var dialog_text: DialogText = DB.table("dialog_text").find(self._dialog_text_id)
                    if dialog_text.next_dialog_text_id > 0:
                        self._dialog_text_id = dialog_text.next_dialog_text_id
                        self._init_line(dialog_text.next_dialog_text_id)
                        return
                    self.visible = false
                    self._dialog_text_id = 0 
                    self.dialog_finished.emit()


func _physics_process(delta: float) -> void:
    if self._delay_ticks_count % _DELAY_TICKS_PERIOD == 0:
        self._delay_ticks_count = 0
        if %ContentLabel.visible_characters < %ContentLabel.text.length():
            %ContentLabel.visible_characters = %ContentLabel.visible_characters + 1
    self._delay_ticks_count = self._delay_ticks_count + 1


func _init_line(dialog_text_id: int) -> void:
    var dialog_text: DialogText = DB.table("dialog_text").find(dialog_text_id)
    %ContentLabel.text = dialog_text.text
    %ContentLabel.visible_characters = 0
    self._delay_ticks_count = 0


func start_dialog(dialog_text_id: int) -> Signal:
    self._dialog_text_id = dialog_text_id
    self._init_line(dialog_text_id)
    self.visible = true
    return self.dialog_finished
