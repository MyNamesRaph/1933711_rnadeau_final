extends Node



func _on_Play_pressed():
	get_parent().play()


func _on_Quit_pressed():
	get_parent().quit()



func _on_Restart_pressed():
	get_parent().get_parent().reset()
