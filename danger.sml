(*use "C:\\Users\\thy\\Desktop\\danger.sml";*)
fun danger file =
let
fun read_from_file input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
val stream = TextIO.openIn file
val num_of_meters = read_from_file stream
val num_of_combinations = read_from_file stream (*read the number of all meters and combinations*)
(*for all combinations you have to take out at least one meter in order to have non hazard combinations. Tha vroume ton elaxisto arithmo metrwn
pou prepei na diwksoume kai ara ton megisto arithmo metrwn pou tha krathsoume. Ksekiname me mia lista poy periexei ola ta stoixeia toy prwtoy syndyasmou
tha diatreksoume olous tous syndyasmous kai ean ena metro toy syndyasmou pou tsekaρoume einai kai stoixeio twn sets ths listas pou exoyme tote pame ston
epomeno stoixeio ths listas giati den exei nohma na to diwksoume afou exoume hdh diwksei kapoio metro apo ton syndyasmo kai eimaste ok gi ayto to stoixeio*)

val initial_list=if num_of_combinations=0 then []
else (*ftiaxnw thn arxikh lista gia ton prwto syndyasmo*)
let
	fun make_initial_list_of_sets 0 list = list
	| make_initial_list_of_sets n list = let
	val new_element=read_from_file stream
	in
	make_initial_list_of_sets (n-1) ((IntListSet.singleton new_element)::list)
	end
in
make_initial_list_of_sets (read_from_file stream) []
end

(*gia kathe syndyasmo tha ftiaxnoume to set pou periexei ta metra toy*)
fun make_combination_set 0 acc = acc
| make_combination_set n acc = let 
val new_element=read_from_file stream (*diavase to kainourgio stoixeio toy syndyasmou*)
in
make_combination_set (n-1) (IntListSet.add(acc,new_element)) (*prosthese to stoixeio sto set toy combination*)
end

fun make_list_of_new_sets combination_set set2 list = 
if (IntListSet.numItems(IntListSet.intersection (combination_set, set2)))=0 then 
	let
		fun insert_sets [] list = list
		| insert_sets (h::t) list = 
			let
			val new_set = IntListSet.add(set2, h)
			in
			insert_sets t (new_set::list)
			end
	in
	insert_sets (IntListSet.listItems combination_set) list
	end
else set2::list

(*prepei na tsekaroume olous toys syndyasmous kai tha epistrepsoume thn lista me olous toys pithanous syndyasmous metrwn poy tha diwksoume. 
Oi pithanoi syndyasmoi metrwn tha einai o kathe enas toys se ena set*)
fun for_all_combinations m list = if m<1 then list
else 
let
	val combination_set = 
		let
			val how_many_meters = read_from_file stream (*diavazoume posa metra exei enas syndyasmos*)
		
			(*gia kathe syndyasmo tha ftiaxnoume to set pou periexei ta metra toy*)
			fun make_combination_set 0 acc = acc
			| make_combination_set n acc = 	
				let 
					val new_element=read_from_file stream (*diavase to kainourgio stoixeio toy syndyasmou*)
				in
					make_combination_set (n-1) (IntListSet.add(acc,new_element)) (*prosthese to stoixeio sto set toy combination*)
				end
		in
			make_combination_set how_many_meters (IntListSet.empty)
		end
	val combination_list = IntListSet.listItems(combination_set)
	fun update_list combination_set combination_list acc []=acc
	| update_list combination_set combination_list acc (h::t)= update_list combination_set combination_list (make_list_of_new_sets combination_set h acc) t	
in
	for_all_combinations (m-1) (update_list combination_set combination_list [] list)
end

(*make the set of all meters included*)
val set_of_all_meters=
let
fun make_set_of_all_meters 0 set = set
|make_set_of_all_meters num set = make_set_of_all_meters (num-1) (IntListSet.add (set,num))
in 
make_set_of_all_meters num_of_meters (IntListSet.empty)
end

val min = IntListSet.empty;
(*initialize minimum value*)

fun find_the_minimum_set [] min = min
| find_the_minimum_set (h::t) min= 
let
fun find_min [] min = min
| find_min (h::t) min = if IntListSet.numItems(h)<IntListSet.numItems(min) then find_min t h
else find_min t min 
in 
find_min t h
end
(*fun to_list list = map (fn x => IntListSet.listItems(x)) list;*)

fun list_of_maximum_meters set_of_all minimum_set = IntListSet.listItems(IntListSet.difference(set_of_all_meters, minimum_set));
in
list_of_maximum_meters set_of_all_meters (find_the_minimum_set (for_all_combinations (num_of_combinations - 1) initial_list) min)
end;







