extends OptionButton

const RESOLUTIONS : Dictionary[String, Vector2i] = {
	"400 x 225": Vector2i(400, 225),
	"800 x 450": Vector2i(800, 450),
	"1280 x 720": Vector2i(1280, 720),
	"1600 x 900": Vector2i(1600, 900),
	"1920 x 1080": Vector2i(1920, 1080),
	"2560 x 1440": Vector2i(2560, 1440),
	"3840 x 2160": Vector2i(3840, 2160),
}

var base_window_size := Vector2(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height")
)

func _ready() -> void:
	for resolution in RESOLUTIONS:
		add_item(resolution);

	print("Window Size: %s" % get_window().size);
	print("Window is Window Viewport: %s" % (get_window() == get_window().get_viewport()));


func _on_item_selected(index: int) -> void:
	var new_resolution_string = get_item_text(index);
	var new_resolution = RESOLUTIONS[new_resolution_string];
	var top_left := DisplayServer.screen_get_position(DisplayServer.SCREEN_OF_MAIN_WINDOW);
	var screen_size := DisplayServer.screen_get_size(DisplayServer.SCREEN_OF_MAIN_WINDOW);
	var new_position = top_left + (screen_size / 2) - (new_resolution / 2);
	DisplayServer.window_set_position(new_position);
	get_window().size = new_resolution;

	print("Changed Window Size to %s:" % new_resolution);
	print("Window Size: %s" % get_window().size);
	print("Window is Window Viewport: %s" % (get_window() == get_window().get_viewport()));
	print("Scaling Factor: %s" % get_window().content_scale_factor);
	print("Scaling Size: %s" % get_window().content_scale_size);
