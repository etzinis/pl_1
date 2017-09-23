val stream = TextIO.openIn "C:\\Users\\thy\\Desktop\\test.txt";
fun read_int input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input);
fun read_real input =
	let
		fun next_real input = Option.valOf (TextIO.inputLine input)
		val (SOME v) = Real.fromString (next_real stream)
	in 
		v
	end;

val BUF_SIZE = read_int stream;

type Building = {xs:int,xt:int,y:int,height:real}

(*Reads a single building*)
fun read_building nil =
	let
		val txs = read_int stream
		val ty = read_int stream
		val txt = read_int stream
		val _ = read_int stream
		val theight = read_real stream 
	in
		{xs=txs, xt=txt, y=ty,height=theight}
	end
	
fun 	read_file(0,build_list) = build_list
|	read_file (i:int,build_list) = 
		let
			val new_list = (read_building nil)::build_list
		in
			read_file(i-1, new_list)
		end
val build_list = read_file(BUF_SIZE,[]);

(*Merge sort and helpers for the creation of various lists-arrays*)

fun		split_list ((l1,l2),[]) = (l1,l2) 
|		split_list ((l1,l2),h1::[]) = (h1::l1,l2)
|		split_list ((l1,l2),h1::h2::[]) = (l1@[h1],l2@[h2])
|		split_list ((l1,l2),h1::h2::t) = split_list((l1@[h1],l2@[h2]),t)

fun split_null l = split_list(([],[]),l)


fun merge ([], []) = []
|	merge (l1, []) = l1
|	merge ([], l2) = l2
|	merge (h1::t1,h2::t2) = if h1 < h2 then h1::merge(t1, h2::t2) else h2::merge(h1::t1,t2)

fun	merge_sort ([]) = []
| 	merge_sort ((h1)::[]) = h1::[]
|	merge_sort ((h1)::(h2)::[]) = if h1 > h2 then h2::h1::[] else h1::h2::[] 
|	merge_sort (h1::h2::t) = 
	let
		val new_lists = split_null(h1::h2::t)
		val list1 = #1 new_lists
		val list2 = #2 new_lists
	in
		merge (merge_sort(list1),merge_sort(list2))
	end

(*Creation of the horizon from the x coordinates*)

fun extract_horizon(h::[]:Building list) = (#xs h)::(#xt h)::[] 
|	extract_horizon(h::t:Building list) = (#xs h)::(#xt h)::extract_horizon(t)


(*Remove duplicates*)
(*DANGER: NO TAIL RECURSION, POSSIBLE BOTTLENECK*)
fun dedup([]) = []
|	dedup(h::[]) = h::[]
|	dedup(h1::h2::[]) = if h1 = h2 then h1::[] else h1::h2::[]
|	dedup(h1::h2::t) = if h1 = h2 then dedup(h1::t) else h1::dedup(h2::t)


(*Special sorting functions to sort the building by their y coordinate*)
fun merge_build ([], []) = []
|	merge_build (l1, []) = l1
|	merge_build ([], l2) = l2
|	merge_build ((h1:Building)::t1,(h2:Building)::t2) = if ((#y) h1) > ((#y) h2) then h1::merge_build(t1, h2::t2) else h2::merge_build(h1::t1,t2)


fun	merge_sort_building ([]:Building list) = []
| 	merge_sort_building ((h1)::[]) = h1::[]
|	merge_sort_building ((h1)::(h2)::[]) = if (#y h1) < (#y h2) then h2::h1::[] else h1::h2::[] 
|	merge_sort_building (h1::h2::t) = 
	let
		val new_lists = split_null(h1::h2::t)
		val list1 = #1 new_lists
		val list2 = #2 new_lists
	in
		merge_build (merge_sort_building(list1),merge_sort_building(list2))
	end

val horizon = Array.fromList(dedup(merge_sort(extract_horizon(build_list))));
val tops = Array.array(Array.length(horizon), 0.0);
val build_array =  Array.fromList(merge_sort_building(build_list));

fun binary_search(build:Building, horizon:int array, start:int, ending:int) = 
	let
		val new_point = Array.sub(horizon,(start + ending) div 2)
	in
		if (new_point = (#xs build)) then new_point 
		else if(start = ending) then ~1
		else if(#xs build < new_point) then binary_search(build, horizon, start, new_point) 
		else binary_search (build, horizon, new_point, ending)
	end

fun insert_building(iterator:int, build:Building, value:bool) = 
	if(Array.sub(horizon, iterator) < (#xt build)) then value
	else if ((Array.sub(tops, iterator)) < (#height build)) then
		let
			val _ = Array.update(tops, iterator, (#height build))
		in 
			insert_building ((iterator+1), build, true)
		end
	else insert_building ((iterator+1), build, value)


fun final_computation(0, current)= 
	if insert_building(binary_search(Array.sub(build_array,0), horizon, 0, Array.length(horizon)-1), 
			Array.sub(build_array,0), false) 
		then current+1 
	else current
|	final_computation(n, current) = 	
		if insert_building(binary_search(Array.sub(build_array,n), horizon, 0, Array.length(horizon) - 1), 
				Array.sub(build_array,n), false) 
			then final_computation (n-1,current+1) 
		else final_computation (n-1,current)

fun search(0, truth)= 
		binary_search(Array.sub(build_array,0), horizon, 0, Array.length(horizon) - 1) 
|	search (n, truth) = 
		let
			val temp = binary_search(Array.sub(build_array,n), horizon, 0, Array.length(horizon) - 1)
		in
			search (n-1, 1)
		end

val it = search(BUF_SIZE-1, 1);	

val result = final_computation(BUF_SIZE-1,0);