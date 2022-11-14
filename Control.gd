extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dirty = {
	"logo": null,
	"music": {},
	"sprites": {}
}
var file = File.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$NativeDialogSaveFile.show()
	
	var files = yield($NativeDialogSaveFile,"file_selected")
	
	if(files != ""):
		dirty = {
			"logo": null,
			"music": {},
			"sprites": {}
		}
		
		file.open_compressed(files, File.WRITE, File.COMPRESSION_GZIP)
		
		if($LineEdit.text != ""):
			dirty.logo = $LineEdit.text
		
		for child in $VBoxContainer.get_children():
			if(child.pressed):
				var stream = load("res://Assets/Music/" + child.name + ".ogg")
				
				dirty.music[child.name] = stream
			else:
				dirty.music[child.name] = null
		
		for child in $VBoxContainer2.get_children():
			if(child.pressed):
				var sprite = load("res://Assets/Sprites/" + child.name + ".png")
				
				dirty.sprites[child.name] = sprite.get_data()
			else:
				dirty.sprites[child.name] = null
		
		file.store_var(dirty, true)
		file.close()
		
		OS.alert("FFMOD written!")
	
	pass # Replace with function body.
