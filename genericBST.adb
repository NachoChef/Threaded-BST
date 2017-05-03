package body genericBST is
   procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
				          custName: in AKey; custPhone: AKey) is
      P : BinarySearchTreePoint;
      T : BinarySearchTreePoint := new Node'(Info => makeRecord(custName, custPhone)); 
   begin
      if Root = null then
         Root := T;
      else
         P := Root;
         loop
            if custName < P.Info then --ins left
               if P.LLink /= null then
                  P := P.LLink;
               else
                  T.LLink := P.LLink; T.LTag := P.LTag;
                  P.LLink := T; P.LTag := true; 
                  T.RLink := P; T.RTag := false;
                  exit;
               end if;
            elsif custName > P.Info then --ins right
               if P.RLink /= null then
                  P := P.RLink;
               else 
                  T.RLink := P.RLink; T.RTag := P.RTag;
                  P.RLink := T; P.RTag := true; 
                  T.LLink := P; T.LTag := false;
                  exit;
               end if;
            else
               exit;
            end if;
         end loop;
      end if;
   end InsertBinarySearchTree;
                      
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := Root.LLink;
   begin
      loop
         if CustomerName /= T.Info then
            if CustomerName > T.Info then
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
      if CustomerName < T.Info then
         if T.LTag then
            FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
         end if;
      elsif CustomerName > T.Info then
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
   
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint; Root : in BinarySearchTreePoint) is
      T : BinarySearchTreePoint := TreePoint;
      Q : BinarySearchTreePoint;
   begin
      if TreePoint = Root then
         T := TreePoint.LLink;
      else
         myPutRec(TreePoint.Info);
      end if;
      Q := T;
      loop
         myPutRec(Q.Info);
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
		while not empty loop
			pop(P);
			myPutRec(P.Info);
		end loop;
   end PostOrderIterative;
   
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
      Phone : AKey;
   begin
      if TreePoint /= R then
			if TreePoint.LTag then
				PostOrderRecursive(TreePoint.LLink);
			end if;
			if TreePoint.RTag then
				PostOrderRecursive(TreePoint.RLink);
			end if;
			myPutRec(TreePoint.Info);
      else
			PostOrderRecursive(TreePoint.LLink);
		end if;
   end PostOrderRecursive;
   
   
----------------------------------------------------------------------
   procedure makeTree(file : String) is
      Input_Exception : Exception;
      input : KeyIO.File_Type;
      Root : BinarySearchTreePoint;
      op, T1, T2 : AKey;
   begin
      Open(input, in_file, "input.txt");
      begin
         Get(input, op);
         case(op) is
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
               null;
            when 6 =>
               null;
            when 7 =>
               null;
            when 8 =>
               null;
            when 9 =>
               null;
            when 10 =>
               null;
            when others =>
               raise Input_Exception;
         end case;
         Close(input);
      end;
   end makeTree;
   
end genericBST;