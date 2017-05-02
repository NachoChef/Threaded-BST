package body genericBST is
   procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
				          custName: in AKey; custPhone: AKey) is
   begin
      null;
   end InsertBinarySearchTree;
                      
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := Root.LLink;
      found : Boolean := False;
   begin
      loop
         if CustomerName /= getName(T) then
            if CustomerName > getName(T) then
               if T.RTag then
                  T := T.Rlink;
               else
                  exit;
               end if;
            else
               if T.LTag then
                  T := T.LLink;
               else
                  exit;
               end if;
            end if;
         else
            CustomerPoint := T;
            exit;
         end if;
      end loop;
   end FindCustomerIterative;
                      
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint;
   begin
      if Root.RLink = Root then
         T := Root.LLink;
      else
         T := Root;
      end if;
      if CustomerName < getName(T) then
         if T.LTag then
            FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
         end if;
      elsif CustomerName > getName(T) then
         if T.RTag then
            FindCustomerRecursive(T.RLink, Customername, CustomerPoint);
         end if;
      else
         CustomerPoint := T;
      end if;
      
   end FindCustomerRecursive;
                      
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
      T : BinarySearchTreePoint;
   begin
      T := TreePoint.RLink;
      if TreePoint.RTag then
         while T.LTag loop
            T := T.LLink;
         end loop;
      end if;
      return T;
   end InOrderSuccessor;
   
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := TreePoint;
      Q : BinarySearchTreePoint;
   begin
      if TreePoint = Root then
         T := TreePoint.LLink;
      else
         put(getName(TreePoint)); New_Line;
      end if;
      Q := T;
      loop
         myPutRec(Q); New_Line;
         if Q.LTag then
            Q := Q.LLink;
         else
            if not Q.RTag then
               Q := Q.RLink.Rlink;
            else
               Q := Q.Rlink;
            end if;
         end if;
         if Q = Root then
            Q := Q.LLink;
         end if;
         exit when Q = T;
      end loop;
   end PreOrder;      
   
	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
      P, T : BinarySearchTreePoint;
   begin
      if TreePoint = R then
			P := TreePoint.LLink;
		else 
			P := TreePoint;
		end if;
		T := P;
		loop
			Push(T);
			if P.RTag then
				T := P.RLink;
			else
				while not T.LTag loop
					T := T.LLink;
				end loop;
         T := T.LLink;
			end if;
			P := T;
			if TreePoint = R then
				exit when P = TreePoint.LLink;
			else 
				exit when P = TreePoint;
			end if;
		end loop;
		     put(" | ");   
		while not empty loop
			pop(P);
			Phone := CustomerPhone(P);
			for i in 1..10 loop
				Put(Phone(i));
			end loop;Put("/ ");
			NamesIO.Put(CustomerName(P));New_Line;
		end loop;
   end PostOrderIterative;
   
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
   begin
      if TreePoint /= R then
			if TreePoint.LTag then
				PostOrderRecursive(TreePoint.LLink);
			end if;
			if TreePoint.RTag then
				PostOrderRecursive(TreePoint.RLink);
			end if;
			Phone := CustomerPhone(TreePoint);
			for i in 1..10 loop
				Put(Phone(i));
			end loop;
         Put("/ ");
			NamesIO.Put(getName(TreePoint));New_Line;
      else
			PostOrderRecursive(TreePoint.LLink);
		end if;
   end PostOrderRecursive;
   
   procedure makeTree(file : String) is
      Input_Exception : Exception;
      file : KeyIO.File_Type;
      Root : BinarySearchTreePoint;
      op, T1, T2 : AKey;
   begin
      Open(input, in_file, "input.txt");
      begin
         Get(input, op);
         case(AKey'Value(op)) is
            when 1 =>
               Get(input, T1); Get(input, T2);
               InsertBinarySearchTree(Root, T1, T2);
            when 2 =>
               Get(input, T1); Get(input, T2);
               FindCustomerIterative(Root, T1, T2);
            when 3 =>
               Get(input, T1); Get(input, T2);
               FindCustomerRecursive(Root, T1, T2);
            when 4 =>
               put_line("NULL");
            when 5 =>
            when 6 =>
            when 7 =>
            when 8 =>
            when 9 =>
            when 10 =>
            when others =>
               raise Input_Exception;
   
end genericBST;