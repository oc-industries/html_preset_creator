extends Control


func play_info(text):
	$Label.text = text
	$AnimationPlayer.stop()
	$AnimationPlayer.play("fade")
