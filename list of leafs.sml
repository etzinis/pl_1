fun leafstolist Empty acc = acc
| leafstolist (Node (datum,tree1,tree2)) acc = 
	if ((tree1=Empty) andalso (tree2=Empty)) then (acc@[datum])
	else (leafstolist tree2 (leafstolist tree1 acc));

fun listoftree tree = leafstolist tree [];