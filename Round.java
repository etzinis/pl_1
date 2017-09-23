import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

public class Round {
			private char one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve;
		    private char c[];
			private Round previous;
			String k = "            ";

			private char temp1;
		
			public Round() {
				
			}
			
			public Round(String s, Round p){
				c = s.toCharArray();
				one = c[0];
				two = c[1];
				three = c[2];
				four = c[3];
				five = c[4];
				six = c[5];
				seven = c[6];
				eight = c[7];
				nine = c[8];
				ten = c[9];
				eleven = c[10];
				twelve = c[11];
				previous = p;				
			}
		
			//check if the Round is final
			public boolean isFinal(){
				if(c[0]=='b'&&c[1]=='g'&&c[2]=='b'&&c[3]=='G'&&c[4]=='g'&&c[5]=='G'&&c[6]=='G'&&c[7]=='r'&&c[8]=='G'&&c[9]=='y'&&c[10]=='r'&&c[11]=='y')
					return true;
				else
					return false;
			}
			
			private static int sit;
			@SuppressWarnings("static-access")
			public void setSit(int sit){
				this.sit = sit;
			}
			public int getSit(){
				return sit;
			}
		
			//make next move-rounding
			public Collection<Round> next(){
				Collection<Round> n = new ArrayList<Round>();
				Round s = new Round(k, this);
				Set<Round> seen = new HashSet<Round>();
					
						temp1 = six;
						six = four;
						four = three;
						three = one;
						one = temp1;
						setSit(1);
						n.add(s);
						if (!seen.contains(n)) {
							seen.add(s);
						}
					
						temp1 = seven;
						seven = five;
						five = four;
						four = two;
						two = temp1;
						setSit(2);
						n.add(s);
						if (!seen.contains(n)) {
							seen.add(s);
						}
					
						temp1 = eleven;
						eleven = nine;
						nine = eight;
						eight = six;
						six = temp1;
						setSit(3);
						n.add(s);
						if (!seen.contains(n)) {
							seen.add(s);
						}
					
						temp1 = twelve;
						twelve = ten;
						ten = nine;
						nine = seven;
						seven = temp1;
						setSit(4);
						n.add(s);
						if (!seen.contains(n)) {
							seen.add(s);
						}
				
				return n;	
			}
		
		
			//we want to keep track of the Rounds we have passed
			public Round previous(){
				return previous;
			}
}