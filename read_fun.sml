(*use "C:\\Users\\thy\\Desktop\\read_fun.sml";*)

fun read_tuple file =
let
	val stream = TextIO.openIn file
	
	fun read_int input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
	
	fun read_real input =
	let
	fun next_real input = Option.valOf (TextIO.inputLine input)
	val (SOME v) = Real.fromString (next_real stream)
	in 
	v
	end
	
	val xsw = read_int stream
	val ysw = read_int stream
	val xne = read_int stream
	val yne = read_int stream
	val height = read_real stream
	val tupla = (xsw,ysw,xne,yne,height) (*k tupla einai ths morfhs (xsw,ysw,xne,yne,height)*)
	fun five_to_4 (a,b,c,d,e) = (a,c,b,e) (*pame thn tupla sthn morfh (Xsw,Xne,Yne,Height)*)
in
	five_to_4 tupla
end;
