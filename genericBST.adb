with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
package body genericBST is
   procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
				          custName: in AKey; custPhone: AKey) is
      P, T : BinarySearchTreePoint;
   begin
      put_line("- inserting -");
      P := Root;
      loop
         if custName < P.Info then --ins left
            if P.LTag then
               P := P.LLink;
            else
               allocateNode(T, custname, custphone);
               insertNode(P, T, custname, custphone);
               myputrec(T.Info);
               exit;
            end if;
         elsif custName > P.Info then --ins right
            if P.RTag then
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
   end InsertBinarySearchTree;
   
   procedure insertNode (P : in out BinarySearchTreePoint; Q : in out BinarySearchTreePoint; name : in Akey; number : IN Akey) is
   begin
      if name < P.Info then
         if getName(P.Info) /= dummy then
            put("Left subtree of "); myputname(getname(P.Info)); New_Line;
         else
            put("New root node!");
         end if;
         Q.LTag := P.LTag; Q.LLink := P.LLink;
         P.LLink := Q; P.LTag := true;
         Q.RTag := false; Q.RLink := P;
      else
         if getName(P.Info) /= dummy then
            put("Right subtree of "); myputname(getname(P.Info)); New_Line;
         else
            put("New root node!");
         end if;
         Q.RTag := P.RTag; Q.RLink := P.RLink;
         P.RLink := Q; P.RTag := true;
         Q.LTag := false; Q.LLink := P; 
      end if;
   end insertNode;
                      
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint;
   begin
      T := Root;
      loop
         if CustomerName < T.Info and T.LTag then
            T := T.LLink;
         elsif CustomerName > T.Info and T.RTag then
            T := T.RLink;
         else
            exit;
         end if;
      end loop;
      CustomerPoint := T;
      if getName(T.Info) /= customerName then
         put_line("Record not found!");
      else
         put("Info found: ");
         myputrec(T.Info);
      end if;
   end FindCustomerIterative;
                      
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := Root;
   begin
      if CustomerName > T.Info and T.RTag then
         FindCustomerRecursive(T.RLink, CustomerName, CustomerPoint);
      elsif CustomerName < T.Info and T.LTag then
         FindCustomerRecursive(T.LLink, CustomerName, CustomerPoint);
      elsif CustomerName /= getName(T.Info) then
         CustomerPoint := null;
         put_line("Record not found!");
      else
         put("Info found: "); myputrec(T.Info);
      end if;
   end FindCustomerRecursive;
                      
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint is
      T : BinarySearchTreePoint := TreePoint;
   begin
      if T.RTag then
         T := T.RLink;
         while T.LTag loop
            T := T.LLink;
         end loop;
      else
         T := T.RLink;
      end if;
      return T;
   end InOrderSuccessor;
   
   procedure DeleteRandomNode(Q: in out BinarySearchTreePoint; Root : in out BinarySearchTreePoint) is
      R, S, T : BinarySearchTreePoint;
   begin
      put("Deleting "); myputrec(Q.Info);
      T := Q;
      if not T.RTag then
         Q := T.LLink;
      else
         if T.RTag then
            Q := T.RLink;
         end if;
         R := T.RLink;
         if not R.LTag then
            R.LLink := T.LLink;
            R.LTag := T.LTag;
            Q := R;
         else
            S := R.LLink;
            while S.LTag loop
               R := S; S := R.LLink;
            end loop;
            S.LLink := T.LLink; S.LTag := T.LTag;
            R.LLink := S.RLink; R.LTag := S.RTag;
            S.RLink := T.RLink; S.RTag := T.RTag;
            Q := S;
         end if;
      end if;
   myputrec(T.Info);
   if Root.LLink = T then 
      Root.LLink := Q;
   else
      if T.LLink = Q then
         T.LLink := Q;
      else
         T.RLink := Q;
      end if;
   end if;
   end DeleteRandomNode;
   
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint; Root : in BinarySearchTreePoint) is
      T : BinarySearchTreePoint := TreePoint;
      Q : BinarySearchTreePoint;
   begin
      put("Traversing preorder from "); myPutRec(TreePoint.Info);
      if T = Root.LLink then
         if T.LTag then
            T := T.LLink;
         else
            T := T.RLink;
         end if;
      else
         myPutRec(T.Info);
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
   
   procedure ReverseInOrder (P : in out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := P;
   begin
      if P.RTag then
         ReverseInOrder(P.RLink);
      end if;
      myPutRec(P.Info);
      if P.LTag then
         ReverseInOrder(P.LLink);
      end if;
   end ReverseInOrder;
   
   function PostOrderSuccessor(TreePoint : in out BinarySearchTreePoint) return BinarySearchTreePoint is
      Q, P : BinarySearchTreePoint := TreePoint;
   begin
      if P.RTag then
         Q := P.RLink;
      else
         while not Q.LTag loop
            Q := Q.LLink;
         end loop;
         Q := Q.LLink;
      end if;
      return Q;
   end PostOrderSuccessor;
   
 	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint) is
      P, T : BinarySearchTreePoint := TreePoint;
      package stack is new gstack(50, BinarySearchTreePoint);
   begin
      put_line("Traversing in postorder");
      P := PostOrderSuccessor(T);   --will loop through reverse order
      stack.push(P);
      P := PostOrderSuccessor(P);
		while P /= T loop
         stack.push(P);
         P := PostOrderSuccessor(P);
      end loop;
      
      while not stack.isEmpty loop
         stack.pop(P);
         myPutRec(P.Info);
      end loop;
      myPutRec(TreePoint.Info);
   end PostOrderIterative;
   
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint) is
   begin
      if TreePoint.LTag then
         PostOrderRecursive(TreePoint.LLink);
      end if;
      if TreePoint.RTag then
         PostOrderRecursive(TreePoint.RLink);
      end if;
      myPutRec(TreePoint.Info);
   end PostOrderRecursive;
   
   procedure allocateNode(Q : out BinarySearchTreePoint; name: in AKey; number : in AKey) IS
   begin
      Q := new Node;
      Q.Info := makeRecord(name, number);
      Q.RTag := true; Q.LTag := false;
      Q.LLink := Q; Q.RLink := Q;
   end;

   procedure makeTree(file : String) is
      Input_Exception : Exception;
      input : KeyIO.File_Type;
      Root : BinarySearchTreePoint := new Node'(null, null, false, true, makeRecord(dummy, dummy));
      
      op, T1, T2 : AKey;
      tempNode, tempNode2 : BinarySearchTreePoint;
   begin
      Root.LLink := Root; Root.RLink := Root;
      Open(input, in_file, "input.txt");
      begin
         while not End_of_file(input) loop
            Read(input, op);
            put(getVal(op)); New_Line;
            case getVal(op) is
               when 1 => 
                  Read(input, T1); Read(input, T2);
                  InsertBinarySearchTree(Root, T1, T2);
               when 2 =>
                  Read(input, T1);
                  put("Searching iteratively for ");myputname(T1); New_Line;
                  FindCustomerIterative(Root, T1, tempNode); 
               when 3 =>
                  Read(input, T1);
                  put("Searching recursively for "); myputname(T1); New_Line;
                  FindCustomerRecursive(Root.LLink, T1, tempNode);
               when 4 =>
                  Read(input, T1);
                  FindCustomerIterative(Root, T1, tempNode);
                  put_line("Traversing inorder from ");
                  myputrec(tempNode.Info);
                  tempNode2 := InOrderSuccessor(tempNode);
                  while tempNode2 /= tempNode loop
                     if tempNode2 /= Root then  --skip Root dummy print
                        myputrec(tempNode2.Info); 
                     end if;
                     tempNode2 := InOrderSuccessor(tempNode2);
                  end loop; 
               when 5 =>
                  put_line("Traversing inorder from root: ");
                  tempNode2 := Root.LLink;
                  while tempNode2 /= Root loop
                     myputrec(tempNode2.Info); tempNode2 := InOrderSuccessor(tempNode2);
                  end loop;
               when 6 =>
                  Read(input, T1);
                  FindCustomerRecursive(Root, T1, tempNode);
                  --delete doesn't work
--                   if tempNode /= null then
--                      DeleteRandomNode(tempNode, Root);
--                   end if;
               when 7 =>
                  tempNode := Root.LLink;
                  put("Traversing in reverse order from "); myputname(getname(tempNode.Info));
                  New_Line;
                  ReverseInOrder(Root.LLink);
               when 8 =>
                  Preorder(Root.LLink, Root);
               when 9 =>
                  PostorderIterative(Root.LLink);
               when 10 =>
                  PostOrderRecursive(Root.LLink);
               when others =>
                  raise Input_Exception;
            end case;
         end loop;
         Close(input);
      end;
   end makeTree;
   
end genericBST;