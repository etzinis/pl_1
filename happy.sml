(*use "C:\\Users\\thy\\Desktop\\happy.sml";*)
fun get_last_digit n = n mod 10;
fun pow x = x * x;
fun pow_to_list list = map pow list;
fun find_sum list = foldr (op +) 0 (pow_to_list list);
val powerarray = Array.array(10,0);
fun update_array 10 arr = arr
| update_array i arr = 
	let val yolo=(Array.update(arr,i,(pow(i+1)-pow(i))))
	in
	update_array (i+1) arr
	end;
val powerarray = update_array 0 powerarray;
fun num_to_list n = 
	if n>9 then( n mod 10 :: num_to_list (n div 10))
	else [n mod 10];
fun souma1 n acc = 
	if n > 9 then souma1 (n div 10) (acc + pow(n mod 10))
	else acc + pow(n mod 10);
fun souma n = souma1 n 0;
fun check_happy i = 
	if ((souma i) = 1) orelse ((souma i) = 4) then ((souma i) mod 2)
	else check_happy (souma i);
fun make_happylist acc i =
	if i<730 then 
		if (check_happy i) = 1 then make_happylist (i::acc) (i+1)
		else make_happylist (acc) (i+1)
	else rev(acc);
val happylist = make_happylist [] 1;

fun zero_padding list =
	if length(list)=10 then list
	else zero_padding(list @ [0]);

fun is_in_list x [] = false
| is_in_list x (h::t) = 
	if x=h then true
	else is_in_list x t;
	
fun make_lists_to_lists_to_lists i list=
	if i<9 then
				let
					fun make_zero_list_to_list i list = 
					if i<10 then
							let
							val zero_list_10 = [0,0,0,0,0,0,0,0,0,0]
							in
							make_zero_list_to_list (i+1) (zero_list_10 :: list)
					end
					else list;
					val zero_to_zero = make_zero_list_to_list 0 []
				in
				make_lists_to_lists_to_lists (i+1) (zero_to_zero :: list)
				end
	else list;
(*val ltoltol = make_lists_to_lists_to_lists 1 [];*)

fun turn_it_one n l1 [] = l1
| turn_it_one n l1 (h::t)= if n>0 then turn_it_one (n-1) (l1@[h]) t
						   else l1@((h+1)::t);
						  
fun get_that n (h::t) = if n>0 then get_that (n-1) t	
						else h;
						
fun up2 n acc (h::t) = if (n div 10)>0 then up2 (n-10) (acc@[h]) t
					   else acc@((turn_it_one (n mod 10) [] h)::t);
fun up1 n acc (h::t) = if (n div 100)>0 then up1 (n-100) (acc@[h]) t
					   else acc@((up2 (n mod 100) [] h)::t);
fun update num l2 = up1 (num) [] l2;
	
						
fun update_ltoltol [] l2 i = l2
| update_ltoltol (h::t) l2 i = 
	if i>1 then update_ltoltol t (update h l2) (i-1)
	else l2;

val ishappy = update_ltoltol happylist (make_lists_to_lists_to_lists 1 []) 730;

fun plus_one_list [] sum = ([], sum)
| plus_one_list (h::t) sum =
	if h=9 then  let val yolo = plus_one_list t (sum-81)
				 in
				 (0::(#1 yolo), (#2 yolo))
				 end
	else (((h+1)::t), sum +(Array.sub(powerarray,h)));
	
fun find (alist, sum) a b num = 
	if a<b then 
		if get_that(sum mod 10) (get_that ((sum div 10) mod 10) (get_that (sum div 100) ishappy))=1 then find (plus_one_list alist sum) (a+1) b (num+1)
		else find (plus_one_list alist sum) (a+1) b num
	else num;
	
fun findhappies a b = find (zero_padding ((num_to_list a)), souma a) a (b+1) 0;