extends Control

# Poor documentation / code msg goes BRRRRRRRRR

var save_dir = ""
var save_name = ""


var meta = """"""
var head = """"""
var foot = """"""
var page_name = "Webpage!"
var css
var js
var info = ""


var save_page_name = true
var save_css_path = true
var save_js_path = true

func _ready():
	$TabContainer.current_tab = 3


func update_var():
	meta = $TabContainer/Metadata/code.text
	head = $TabContainer/Header/code.text
	foot = $TabContainer/Footer/code.text
	js = $"TabContainer/General Settings/js".text
	css = $"TabContainer/General Settings/css".text
	page_name = $"TabContainer/General Settings/pagename".text
	info = $"TabContainer/General Settings/preset_info".text
	
	$save.current_path = FM.current_path
	$load_preset.current_path = FM.current_path
	
	FM.save_app()
	


func check_for_save():
	var can_save = false
	if save_dir != "":
		can_save = true
	
	if save_name != "":
		can_save = true
	
	if can_save == false:
		$save_preset/save_preset_button.disabled = true
		$save_html/save_html_button.disabled = true
	else:
		$save_preset/save_preset_button.disabled = false
		$save_html/save_html_button.disabled = false
	
	return can_save



func _input(event):
	if Input.is_action_just_pressed("export"):
		if check_for_save() == true:
			FM.save_preset()
		
		if check_for_save() == false:
			$info.play_info(str("Error: No name / save dir for this preset."))
	
	if Input.is_action_just_pressed("save"):
		if check_for_save() == true:
			FM.save_preset()
		else:
			$info.play_info(str("Error: No name / save dir for this preset."))
	



func _on_save_dir_selected(dir):
	FM.current_path = dir
	save_dir = dir
	update_var()
	$save_html/path.text = dir
	$save_preset/path.text = dir

# Top buttons:

func _on_preset_save_pressed(): # When saves to preset
	$save_preset.popup_centered()
	update_var()
	check_for_save()

func _on_html_save_pressed():  # When saves to HTML
	$save_html.popup_centered()
	update_var()
	check_for_save()

func _on_load_preset_file_selected(path):
	FM.current_path = path
	FM.load_preset(path)
	

func _on_about_pressed():
	$about.popup_centered()


func _on_new_pressed():
	get_tree().reload_current_scene()

func _on_preset_load_pressed():
	$load_preset.popup_centered()


# Misc stuff:

func _on_search_pressed():
	$save.popup_centered()

func _on_TabContainer_tab_changed(tab):
	update_var()

func _on_pagenamesave_toggled(button_pressed):
	save_page_name = button_pressed

func _on_csspathsave_toggled(button_pressed):
	save_css_path = button_pressed

func _on_jspathsave_toggled(button_pressed):
	save_js_path = button_pressed

# Save Dialogs:

func _on_save_preset_button_pressed():
	update_var()
	FM.save_preset()

func _on_save_html_button_pressed():
	update_var()
	FM.save_html()

# When changing save inputs:

func _on_filename_text_changed(new_text):
	save_name = new_text
	check_for_save()

func _on_path_text_changed(new_text):
	check_for_save()
