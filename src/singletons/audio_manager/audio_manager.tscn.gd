extends Node


func play_bgm(stream: AudioStream):
    $BGM.stream = stream
    $BGM.play()
