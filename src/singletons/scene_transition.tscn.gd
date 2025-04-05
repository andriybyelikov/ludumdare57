extends Node


func fade_in() -> Signal:
    $AnimationPlayer.play("fade_in")
    return $AnimationPlayer.animation_finished


func fade_out() -> Signal:
    $AnimationPlayer.play("fade_out")
    return $AnimationPlayer.animation_finished
