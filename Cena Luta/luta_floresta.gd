extends Node2D
@onready var mago = get_node("MagoFloresta")
var questoes = ["Maria tinha 35 figurinhas e ganhou 27 de sua amiga.\nQuantas figurinhas maria tem agora?","A aula começou às 8 horas da manhã e terminou às 10 horas.\n Quanto tempo durou a aula?","Cada pacote tem 6 lápis.\nQuantos lápis há em 4 pacotes?","Um sorvete custa R$ 7,00 e um refrigerante custa R$ 5,00.\nSe Ana comprar 2 sorvetes e um refrigerante, quanto ela vai gastar ao todo?","Pedro tinha 60 maçãs em seu pomar. Ele vendeu 25.\nQuantas maçãs ainda ficaram com Pedro?"]
var alternativas = [["62","61","73","52","72"],["3","4","1","2","5"],["23","24","20","21","14"],["19","16","13","20","18"],["34","35","25","28","45"]]
var respostas = [1,4,2,1,2]
var n = randi_range(0, 4)
var passadas =[n]
var clique = -1
var libera = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var quest:String = questoes[n]
	$Control/Label.text = quest
	$Control/Button.text = alternativas[n][0]
	$Control/Button2.text = alternativas[n][1]
	$Control/Button3.text = alternativas[n][2]
	$Control/Button4.text = alternativas[n][3]
	$Control/Button5.text = alternativas[n][4]
	
	if clique==respostas[n] and libera:
		diminui_vida_inimigo()
		if $CanvasLayer/AnimatedSprite2D.animation == "HIT":
			$Camera2D/Control.visible = true
			$Control.visible = false
			
		
		
		if passadas.size() == 5:
			get_tree().change_scene_to_file("res://Cenas/bioma_floresta.tscn")
		else:
			salv_quest()
		libera = false
	elif clique!=respostas[n] and libera:
		diminui_vida_propria()
		if passadas.size() == 5:
			get_tree().change_scene_to_file("res://Cenas/bioma_floresta.tscn")
		else:
			salv_quest()
		
		libera = false


func _on_button_pressed() -> void:
	clique = 1
	libera = true
func _on_button_2_pressed() -> void:
	clique = 2
	libera = true
func _on_button_3_pressed() -> void:
	clique = 3
	libera = true
func _on_button_4_pressed() -> void:
	clique = 4
	libera = true
func _on_button_5_pressed() -> void:
	clique = 5
	libera = true

func diminui_vida_inimigo():
	var coracoes = [
	$CanvasLayer/AnimatedSprite2D3,
	$CanvasLayer/AnimatedSprite2D2,
	$CanvasLayer/AnimatedSprite2D
	]

	for c in coracoes:
		if c.animation =="coracaoFull":
			c.play("HIT")
			break
func diminui_vida_propria():
	pass
	
func salv_quest():
	var correto = true
	while  true:
		n = randi_range(0, 4)
		for  a in range(passadas.size()):
			
			if passadas[a]==n:
				correto = false
				break
			else: correto=true
		if  correto:break
	passadas.push_back(n)


func _on_voltar_pressed() -> void:
	Global.mago_vivo = 0
	get_tree().change_scene_to_file("res://Cenas/bioma_floresta.tscn")
