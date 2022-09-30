extends HTTPRequest

var api_map_url = "https://naazeri.ir/game-api/poke/v1/map/"
var last_request_url

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_use_threads(true)
	self.connect("request_completed", self, "_on_request_completed")
	get(api_map_url)

func get(url):
	last_request_url = url
	self.request(api_map_url)

func _on_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray):
	if result == OK and response_code == 200:
		var data = body.get_string_from_utf8()
		var json = JSON.parse(data)
		print(headers)
		print(json.result)
	else:
		print("error on server request: ", response_code)
