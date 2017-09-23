
fun sets l1 [] = []
| sets l1 (h::t) = ( l1 @ [h] )::sets (l1 @ [h]) t;

fun allsets [] all = all
| allsets (h::t) all = 
	let
	val newall = all @ (sets [] (h::t))
	in
	allsets t newall
	end;

fun findsets [] = []
| findsets listofsets = []::(allsets listofsets []);

fun subsets xs = foldr (fn (x, rest) => rest @ map (fn ys => x::ys) rest) [[]] xs

fun insertAll(a,nil) = nil
|   insertAll(a,L::Ls) = (a::L)::insertAll(a,Ls);

fun powerSet(nil) = [nil]
|   powerSet(x::xs) =
		let
			val L = powerSet(xs)
		in
			L @ insertAll(x,L)
		end;