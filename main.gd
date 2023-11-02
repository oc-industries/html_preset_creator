extends Control

var save_dir = ""
var save_name = ""
var config = ConfigFile.new()

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
			save_preset()
		
		if check_for_save() == false:
			$info.play_info(str("Error: No name / save dir for this preset."))
	
	if Input.is_action_just_pressed("save"):
		if check_for_save() == true:
			save_preset()
		else:
			$info.play_info(str("Error: No name / save dir for this preset."))
	

func save_html():
	update_var()
	
	var page_name_str = str("<title>", page_name, "</title>")
	var css_str = str("<link rel=\"stylesheet\" href=\'", css, "'\">")
	var js_str = str("<script src='", js, "'></script>")
	
	if save_css_path == false:
		css_str = ""
	
	if save_page_name == false:
		page_name_str = ""
	
	if save_js_path == false:
		js_str = ""
	
	var content = str(
		page_name_str,"\n",
		css_str,"\n",
		
		meta, "\n", head, "\n ", 
"""
<!--Page Content:-->



<!--Page Content End-->
""", "\n ",foot)
	
	var dir = str(save_dir, "/", save_name, ".html")
	
	var file = File.new()
	file.open(str(dir), file.WRITE)
	file.store_string(content)
	file.close()
	
	
	print(dir)
	$info.play_info(str("Save to html at: ", dir))
	

func save_preset():
	update_var()
	
	config.set_value("data", "metadata", meta)
	config.set_value("data", "header", head)
	config.set_value("data", "footer", foot)
	config.set_value("data", "pagename", page_name)
	config.set_value("data", "css", css)
	config.set_value("data", "js", js)
	config.set_value("data", "info", info)
	
	config.set_value("readme", "copyright", "Copyright 2023 - 2025 OC Industries Game Dev")
	
	var dir = str(save_dir, "/", save_name, ".hpc")
	print(dir)
	config.save(dir)
	
	$info.play_info(str("Save Preset at: ", dir))
	

func load_preset(path):
	config.load(path)
	$TabContainer/Metadata/code.text = config.get_value("data", "metadata")
	$TabContainer/Header/code.text = config.get_value("data", "header")
	$TabContainer/Footer/code.text = config.get_value("data", "footer")
	$"TabContainer/General Settings/css".text = config.get_value("data", "css")
	$"TabContainer/General Settings/pagename".text = config.get_value("data", "pagename")
	$"TabContainer/General Settings/preset_info".text = config.get_value("data", "info")
	update_var()
	
	$info.play_info(str("Loaded Preset from: ", path))
	

func _on_save_dir_selected(dir):
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
	load_preset(path)

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
	save_preset()

func _on_save_html_button_pressed():
	update_var()
	save_html()

# When changing save inputs:

func _on_filename_text_changed(new_text):
	save_name = new_text
	check_for_save()

func _on_path_text_changed(new_text):
	check_for_save()
