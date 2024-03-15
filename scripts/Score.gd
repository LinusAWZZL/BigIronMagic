extends Label

signal readyRead()

func _ready():
	emit_signal("readyRead")


func _on_MenuOverlay_score(score):
	self.text = "Score: %d" % score
