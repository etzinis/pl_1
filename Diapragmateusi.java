//In this solution we followed the BFSolver built in the lab

import java.util.HashSet;
import java.util.Set;
import java.util.Queue;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Collection;

public class Diapragmateusi{
	public static void main (String args[]){
				
		String s=args[0];
		
		Solver solver;
		solver = new BFSolver();
		State initial = new Round(s, null);
		State result  = solver.solve(initial);
		
		printSolution(result);
	}
	
	
	//initial condition	
	interface Solver{
		public State solve (State initial);
	}
	

	//stating the round of the circles
	private static class Round implements State{

		private char one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve;
	
		private Round previous;

		private char temp1;
		
		private static final char[] CHARS = {b, g, b, G, g, G, G, r, G, y, r, y};
	
		public Round(String s, Round p){
			char c[]=s.toCharArray();
			one = c[1];
			two = c[2];
			three = c[3];
			four = c[4];
			five = c[6];
			six = c[6];
			seven = c[7];
			eight = c[8];
			nine = c[9];
			ten = c[10];
			eleven = c[11];
			twelve = c[12];
			previous = p;
		}
	
		//check if the state is final
		public boolean isFinal(){
			return true;
		}
	
	
		//make next move-rounding
		public Collection<State> next(){
			Collection<State> n = new ArrayList<State>();
			String k;
			Round s = new Round(k, this);
			int i=0;
			String[] c;
			for(char CHAR : CHARS)
				if(one!=b || three!=b){
					temp1 = five;
					five = four;
					four = three;
					three = temp1;
					c[i] = "1";
					n.add(s);
				}
				if(two!=g || five!=g){
					temp1 = seven;
					seven = five;
					five = four;
					two = temp1;
					c[i] = "2";
					n.add(s);
				}
				if(eight!=r || eleven!=r){
					temp1 = eleven;
					eleven = nine;
					nine = eight;
					eight = six;
					six = temp1;
					c[i] = "3";
					n.add(s);
				}
				if(ten!=y || twelve!=y){
					temp1 = twelve;
					twelve = ten;
					ten = nine;
					seven = temp1;
					c[i] = "4";
					n.add(s);
				}
				i = i+1;
			
			return n;	
		}
	
	
		//we want to keep track of the states we have passed
		public State previous(){
			return previous;
		}
	
	}


	//print the rounding state
	private static void printSolution (State s){
		// Print the piece of the solution that got us here.
		if (s.previous() != null)
			printSolution(s.previous());
		// And then print this state.
		System.out.println(s);
	}



	//BFSolver gives us the solution with the least moves
	private static class BFSolver implements Solver{
		public State solve (State initial){
			Set<State> seen = new HashSet<State>();
			Queue<State> remaining = new ArrayDeque<State>();

			// Add the initial state to the queue.
			seen.add(initial);
			remaining.add(initial);

			// While the queue contains states to be examined.
			while (!remaining.isEmpty()) {
				// Remove the first remaining state from the queue.
				State s = remaining.remove();
				// If s is final, then just return it.
				if (s.isFinal())
					return s;
				// Find the states that can be reached from this one.
				for (State n : s.next())
					// If n has not been seen before, add it to the queue.
					if (!seen.contains(n)) {
						seen.add(n);
						remaining.add(n);
					}
			}
			// If the queue is empty and no solution was found, return null.
			return null;
		}
	}
}