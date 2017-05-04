with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
package body genericBST is
   procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
				          custName: in AKey; custPhone: AKey) is
      P : BinarySearchTreePoint;
      T : BinarySearchTreePoint; 
   begin
      put_line("inserting");
      if Root = null then
         put_line("NEW ROOT");
         allocateNode(T, custName, custPhone);
         Root := T;
         myPutRec(Root.Info);
      else
         P := Root;
         loop
            if custName < P.Info then --ins left
               if P.LLink /= null then
                  P := P.LLink;
               else
                  allocateNode(T, custname, custphone);
                  insertNode(P, T, custname, custphone);
                  myputrec(T.Info);
                  exit;
               end if;
            elsif custName > P.Info then --ins right
               if P.RLink /= null then
                  P := P.RLink;
               else 
                  allocateNode(T, custname, custphone);
                  insertNode(P, T, custname, custphone);
                  myputrec(T.Info);
                  exit;
               end if;
            else
               exit; --duplicate
            end if;
         end loop;
      end if;
   end InsertBinarySearchTree;
   
   procedure insertNode (P : in out BinarySearchTreePoint; Q : in out BinarySearchTreePoint; name : in Akey; number : IN Akey) is
   begin
      if name < P.Info then
         put_line("Left subtree");
         Q.LTag := P.LTag; Q.LLink := P.LLink;
         P.LLink := Q; P.LTag := true;
         Q.RTag := false; Q.RLink := P;
      else
         put_line("Right subtree");
         Q.RTag := P.RTag; Q.RLink := P.RLink;
         P.RLink := Q; P.RTag := true;
         Q.LTag := false; Q.LLink := P; --caused error
      end if;
   end insertNode;
                      
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint;
   begin
      T := Root;
      loop
         if T /= null then
            if CustomerName < T.Info then
               T := T.LLink;
            elsif CustomerName > T.Info then
               T := T.RLink;
            else
               exit;
            end if;
         else
            exit;
         end if;
      end loop;
      CustomerPoint := T;
      if T = null then
         put_line("Record not found!");
      else
         put("Info found: ");
         myputrec(T.Info);
      end if;
   end FindCustomerIterative;
                      
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint;
   begin
      T := Root;
      if T /= null then
         if CustomerName = T.Info then
             CustomerPoint := T;
             put("Info found: "); myputrec(CustomerPoint.Info);
         elsif CustomerName > T.Info then
             FindCustomerRecursive(T.RLink, CustomerName, CustomerPoint);
         else
             FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
         end if;
      else
         CustomerPoint := T;
         put_line("Record not found!");
      end if;
   end FindCustomerRecursive;
                      
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint; Root : in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
      Q, P : BinarySearchTreePoint;
   begin
      P := TreePoint;
      Q := P.RLink;
      if Q = null then
         Q := Root;
         while Q.LTag /= false loop
            Q := Q.LLink;
         end loop;
         P := Q;
      else
         if Q.LTag = false then
            P := Q;
         else
            while Q.LTag loop
               Q := Q.LLink;
            end loop;
            P := Q;
         end if;
      end if;
      return P;
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
   
-- 	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
--       P, T : BinarySearchTreePoint;
--    begin
--       if TreePoint = R then
-- 			P := TreePoint.LLink;
-- 		else 
-- 			P := TreePoint;
-- 		end if;
-- 		T := P;
-- 		loop
-- 			Push(T);
-- 			if P.RTag then
-- 				T := P.RLink;
-- 			else
-- 				while not T.LTag loop
-- 					T := T.LLink;
-- 				end loop;
--          T := T.LLink;
-- 			end if;
-- 			P := T;
-- 			if TreePoint = R then
-- 				exit when P = TreePoint.LLink;
-- 			else 
-- 				exit when P = TreePoint;
-- 			end if;
-- 		end loop; 
-- 		while not empty loop
-- 			pop(P);
-- 			myPutRec(P.Info);
-- 		end loop;
--    end PostOrderIterative;
   
-- 	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
--       Phone : AKey;
--    begin
--       if TreePoint /= R then
-- 			if TreePoint.LTag then
-- 				PostOrderRecursive(TreePoint.LLink);
-- 			end if;
-- 			if TreePoint.RTag then
-- 				PostOrderRecursive(TreePoint.RLink);
-- 			end if;
-- 			myPutRec(TreePoint.Info);
--       else
-- 			PostOrderRecursive(TreePoint.LLink);
-- 		end if;
--    end PostOrderRecursive;
   
   
----------------------------------------------------------------------
   procedure allocateNode(Q : out BinarySearchTreePoint; name: in AKey; number : in AKey) IS
   begin
      Q := new Node;
      Q.Info := makeRecord(name, number);
      Q.RTag := true; Q.LTag := false;
   end;


   procedure makeTree(file : String) is
      Input_Exception : Exception;
      input : KeyIO.File_Type;
      Root : BinarySearchTreePoint;
      op, T1, T2 : AKey;
      tempNode, tempNode2 : BinarySearchTreePoint;
   begin
      Open(input, in_file, "input.txt");
      begin
         while not End_of_file(input) loop
            Read(input, op);
            put(getVal(op)); New_Line;
            case getVal(op) is
               when 1 =>   --1         Morah     294-1882   after devin
                  Read(input, T1); Read(input, T2);
                  InsertBinarySearchTree(Root, T1, T2);
               when 2 =>
                  Read(input, T1);
                  put("Searching iteratively for ");myputname(T1); New_Line;
                  FindCustomerIterative(Root, T1, tempNode); 
               when 3 =>
                  Read(input, T1);
                  put("Searching recursively for "); myputname(T1); New_Line;
                  FindCustomerRecursive(Root, T1, tempNode);
               when 4 =>
                  Read(input, T1);
                  FindCustomerRecursive(Root, T1, tempNode);
                  put_line("Traversing inorder: ");
                  -- myputrec(tempNode.Info);
--                   tempNode2 := tempNode.RLink;
--                   while tempNode2 /= tempNode loop
--                      myputrec(tempNode2.Info); tempNode2 := InOrderSuccessor(tempNode2, Root);
--                   end loop;
               when 5 =>
                  -- put_line("Traversing inorder from root: ");
--                   myputrec(Root.Info);
--                   tempNode2 := Root.RLink;
--                   while tempNode2 /= Root loop
--                      myputrec(tempNode2.Info); tempNode2 := InOrderSuccessor(tempNode2, Root);
--                   end loop;
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
         end loop;
         Close(input);
      end;
   end makeTree;
   
end genericBST;