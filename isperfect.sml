fun minfactor 1 = 1
	| minfactor n =
		let	
			val m = 2 
		in
			searchfactor m n 
		end;
		
fun searchfactor m n = 
	if (n mod m) = 0 then m
	else searchfactor (m+1) n;
	
fun makelist a list = (a::list);
				
fun factors m n list = 
	if (n mod m) = 0 then makelist m list	
	else list;
	
fun searchallfactors m n list = 
	if m=n then list
	else(
			let	
			val lista = factors m n list
			in
			searchallfactors (m+1) n lista
		 end);
	
fun allfactors n =
	let
		val m = 1
		val list = []
	in
		searcallfactors m n list
	end;
	
fun sumoflist [] = 0
| sumoflist (h::t) = h + sumoflist t;

fun isperfect n =
	if sumoflist( searchallfactors 1 n [] ) = n then true
	else false;
