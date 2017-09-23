(*use "C:\\Users\\thy\\Desktop\\Diapragmateysi.sml";*)

fun StringToList string = 
	let val dalist = String.explode string
	in CharArray.fromList dalist
	end;
	
fun next4steps list i =if i = 1 then let fun makeit (x0::x1::x2::x3::x4::x5::x6::x7::x8::x9::x10::x11::[]) = 
((x2::x1::x5::x0::x4::x3::x6::x7::x8::x9::x10::x11::[]),(x0::x3::x2::x6::x1::x5::x4::x7::x8::x9::x10::x11::[]),(x0::x1::x2::x3::x4::x7::x6::x10::x5::x9::x8::x11::[]),(x0::x1::x2::x3::x4::x5::x8::x7::x11::x6::x10::x9::[]))
fun toString (h1,h2,h3,h4) = (String.implode h1, String.implode h2, String.implode h3, String.implode h4)
in toString (makeit list) end else let fun makeit (x0::x1::x2::x3::x4::x5::x6::x7::x8::x9::x10::x11::[]) = 
((x3::x1::x0::x5::x4::x2::x6::x7::x8::x9::x10::x11::[]),(x0::x4::x2::x1::x6::x5::x3::x7::x8::x9::x10::x11::[]),(x0::x1::x2::x3::x4::x8::x6::x5::x10::x9::x7::x11::[]),(x0::x1::x2::x3::x4::x5::x9::x7::x6::x11::x10::x8::[]))
fun toString (h1,h2,h3,h4) = (String.implode h1, String.implode h2, String.implode h3, String.implode h4)
in toString (makeit list) end 

val hashfun = HashString.hashString
val Hash : (string, string) HashTable.hash_table = 
HashTable.mkTable (hashfun, op=) (100000, Fail "Not Found");
(*we have to create a hashtable with an inserted hashfunction*)

fun makehash string = let
val temp = HashTable.insert Hash (string, "")
in Hash end;

	
(*we have to make a queue in order to save the remaining steps to check *)
 fun makeQ string = let
val Q = Queue.mkQueue()
val t = Queue.enqueue (Q , (string, [])) 
in Q end;

(*Now we have the initial Queue we just have to Solve it by bidirectional BFS by checking the remaining in the Queue of the first and then the
second BFS so we ll have to use 2 different Hash Tables*)
fun BFS initialstr = let
	val H = makehash initialstr
	val Q = makeQ initialstr
	
	val initial = Queue.dequeue Q
	val who=1
	fun TrueBFS H Q (str, list) who= if str = "bgbGgGGrGyry" then list 
	else let

	fun checkNextStates H Q (str, list) = let
		fun updateHandQ H Q	(str, list) n= if (HashTable.find H (str)) <> NONE then (H,Q) 
		else let val tempQ = Queue.enqueue (Q , (str, n::list))
			val tempH = HashTable.insert H (str, String.implode(n::list))
			in (H,Q) end
	
		val nextSteps = next4steps (String.explode str) who
		val (H1, Q1) = updateHandQ H Q (#1(nextSteps), list) #"1"
		val (H2, Q2) = updateHandQ H1 Q1 (#2(nextSteps), list) #"2"
		val (H3, Q3) = updateHandQ H2 Q2 (#3(nextSteps), list)	#"3"
		val (H4, Q4) = updateHandQ H3 Q3 (#4(nextSteps), list)	#"4"
	in (H4, Q4) end
	val (newH, newQ) = checkNextStates H Q (str, list)

	in TrueBFS newH newQ (Queue.dequeue newQ) who end
in TrueBFS H Q initial who end;

val solver_list = String.implode(rev(BFS "gGrGgrGyGbyb"));

