(*use "C:\\Users\\thy\\Desktop\\hapa.sml";*)
fun happy a b=
let
fun pow x = x * x
fun update_array 10 arr = arr
| update_array i arr = 
	let val yolo=(Array.update(arr,i,(pow((i+1) mod 10)-pow(i))))
	in
	update_array (i+1) arr
	end
fun last7souma i []=0
|last7souma 8 list=0
|last7souma i (h::t)=pow(h) + last7souma (i+1) t
fun lsbsouma list = last7souma 1 list
fun first3souma i []=0
|first3souma i (h::t)=
	if i>7 then pow(h) + first3souma (i+1) t
	else first3souma (i+1) t
fun msbsouma list = first3souma 1 list
val powerarray = update_array 0 (Array.array(10,0))
fun num_to_list n = 
	if n>9 then( n mod 10 :: num_to_list (n div 10))
	else [n mod 10]
fun souma1 n acc = 
	if n > 9 then souma1 (n div 10) (acc + pow(n mod 10))
	else acc + pow(n mod 10)
fun souma n = souma1 n 0
fun check_happy i = 
	if ((souma i) = 1) orelse ((souma i) = 4) then ((souma i) mod 2)
	else check_happy (souma i)
fun make_happylist acc i =
	if i<730 then 
		if (check_happy i) = 1 then make_happylist (i::acc) (i+1)
		else make_happylist (acc) (i+1)
	else rev(acc)
fun make_zero_list 1 = [0]
| make_zero_list n = 0::(make_zero_list (n-1))

fun shift n list =
	if n<0 then let fun shiftleft n [] acc = rev(acc)
						| shiftleft 0 list acc = list @ rev(acc)
						| shiftleft n (h::t) acc = shiftleft (n-1) t (h::acc)
				in  shiftleft (~n) list [] end
	else let fun shiftright n [] acc = acc
				| shiftright 0 list acc = acc @ rev(list)
				| shiftright n (h::t) acc= shiftright (n-1) t (h::acc)
		in shiftright n (rev(list)) [] end

fun make_happyarray [] arr = arr
| make_happyarray (h::t) arr = 
	let val yolo=(Array.update(arr,h,1))
	in
	make_happyarray t arr
	end
val happyarray = 
	let 
	val initial=(Array.array(730,0))
	in
	make_happyarray (make_happylist [] 1) initial
	end
fun zero_padding3 list =
	if length(list)=3 then list
	else zero_padding3 (list @ [0])	
fun zero_padding list =
	if length(list)=10 then list
	else zero_padding(list @ [0])
	
fun plus_one_list [] sum = ([], sum)
| plus_one_list (h::t) sum =
	if h=9 then  let val yolo = plus_one_list t (sum-81)
				 in
				 (0::(#1 yolo), (#2 yolo))
				 end
	else (((h+1)::t), sum +(Array.sub(powerarray,h)))
	
val howmanylist =
	let
	val howmanyarray = 
	let 
	val initial=(Array.array(730,0))
	val temp = Array.update(initial,0,1)
	fun make_how_many_array (alist, sum) a arr =  
		if a<10000000 then 
				let val yolo = Array.update(arr,sum,(Array.sub(arr,sum))+1)
				in
				make_how_many_array (plus_one_list alist sum) (a+1) arr
				end
		else arr
	in
	make_how_many_array (zero_padding(num_to_list 1), 1) 1 initial
	end
	fun make_how_many_list 730 list = rev(list)
	   |make_how_many_list n list = make_how_many_list (n+1) ((Array.sub(howmanyarray,n))::list)
	in
	make_how_many_list 0 []
	end
	
fun find (alist, sum) a b num = 
	if a<b then 
		if (Array.sub(happyarray,sum))=1 then find (plus_one_list alist sum) (a+1) b (num+1)
		else find (plus_one_list alist sum) (a+1) b num
	else num
	
fun findmany a b (alist, offset) num howmanylist=
	if a<b then let
				val shifted_list = shift offset howmanylist
				fun plus_one_list1 [] offset = ([], offset)
				| plus_one_list1 (h::t) offset =
				if h=9 then let val yolo = plus_one_list1 t (offset-81)
							in
							(0::(#1 yolo), (#2 yolo))
							end
				else (((h+1)::t), offset +(Array.sub(powerarray,h)))
				fun count [] n= 0
				| count (h::t) n= if (Array.sub(happyarray,n))=1 then h + (count t (n+1))
								  else count t (n+1)
				in 
				findmany (a+1) b (plus_one_list1 alist 0) (num+(count shifted_list 0)) shifted_list
				end
	else num
				
	
fun findhappies a b = if ((b-a) div 10000000)=0 then find (zero_padding ((num_to_list a)), souma a) a (b+1) 0
					  else 	let val adiv = a div 10000000
								val bdiv = b div 10000000
							in
							(find (zero_padding ((num_to_list a)), souma a) a ((adiv + 1) * 10000000) 0) + (findmany (adiv+1) bdiv (zero_padding3(num_to_list(adiv+1)),souma(adiv+1)) 0 howmanylist) + (find (zero_padding ((num_to_list (bdiv * 10000000))), souma bdiv) (bdiv*10000000) (b+1) 0)
							end
in
findhappies a b 
end;							