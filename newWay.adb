with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;

package body newWay is
   
   Root : BinarySearchTreePoint;
   
   function InOrderSuccessor (TreePoint : in BinarySearchTreePoint) return BinarySearchTreePoint is
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
      
   
   procedure InsertBinarySearchTree(Root : in out BinarySearchTreePoint;
                                    custName : in String10; custPhone : in String10) is
      P, T : BinarySearchTreePoint;
   begin
      put_line("INSERTING");
      P := Root;
      loop
         if custName < P.custName then
            if P.LTag then
               P := P.LLink;
            else
               allocateNode(T, custName, custPhone);
               insertNode(P, T, custName, custPhone);
               exit;
            end if;
         elsif custName > P.custName then
            if P.RTag then
               P := P.RLink;
            else
               allocateNode(T, custName, custPhone);
               insertNode(P, T, custName, custPhone);
               exit;
            end if;
         else
            exit; --already in there
         end if;
      end loop;
   end InsertBinarySearchTree;
      
   procedure allocateNode(T : in out BinarySearchTreePoint; custName : String10; custNumber : String10) is
      Q : BinarySearchTreePoint := new Node'(null, null, false, true, custName, custNumber);
   begin
      Q.LLink := Q;
      Q.RLink := Q;
      T := Q;
   end allocateNode;
   
   procedure insertNode (P : in out BinarySearchTreePoint; Q : in out BinarySearchTreePoint;
                        name : in String10; number : in String10) is
   begin
      if P = Root then
         put("Left subtree of "); put(P.custName); New_Line;
         Q.LTag := P.LTag; Q.LLink := P.LLink;
         P.LLink := Q; P.LTag := true;
         Q.RTag := false; Q.RLink := P;
      elsif name < P.custName then
         put("Left subtree of "); put(P.custName); New_Line;
         Q.LTag := P.LTag; Q.LLink := P.LLink;
         P.LLink := Q; P.LTag := true;
         Q.RTag := false; Q.RLink := P;
      else
         put("Right subtree of "); put(P.custName); New_Line;
         Q.RTag := P.RTag; Q.RLink := P.RLink;
         P.RLink := Q; P.RTag := true;
         Q.LTag := false; Q.LLink := P;
      end if;
   end insertNode;
   
   procedure FindCustIterative (Root : in out BinarySearchTreePoint; name : in String10;
                                custPoint : out BinarySearchTreePoint) is
      T : BinarySearchTreePoint := Root.LLink;
   begin
      loop
         if name < T.custName then
            T := T.LLink;
         elsif name > T.custName then
            T := T.RLink;
         else
            exit;
         end if;
      end loop;
      custPoint := T;
      if T.custName /= name then
         put_line("NOT FOUND");
      else
         put("FOUND "); put(custPoint.Custname); New_Line;
      end if;
   end FindCustIterative;           
   
   procedure makeTree is
      op : Integer;
      T1, T2 : String10;
      tempNode1, tempNode : BinarySearchTreePoint;
   begin
      allocateNode(Root, "zzzzzzzzzz", "9999999999");
      put("Enter operation: ");
      get(op);
      loop
         exit when op = 0;
      case op is
         when 1 =>
            get(T1); get(T2);
            InsertBinarySearchTree(Root, T1, T2);
         when 2 =>
            get(T1);
            FindCustIterative (Root, T1,tempNode1);
         when 3 =>
            get(T1);
            FindCustIterative (Root, T1,tempNode1);
            tempNode1 := InOrderSuccessor (tempNode1);
            put_line(tempNode1.custName);
         when 4 =>
            get(T1);
            FindCustIterative (Root, T1, tempNode1);
            put_line(tempNode1.custName);
            tempNode2 := InOrderSuccessor (tempNode1);
            while tempNode2 /= tempNode1 loop
               put_line(tempNode2.custName);
               tempNode2 := InOrderSuccessor (tempNode2);
            end loop;
         when others =>
            null;
      end case;
      put("Enter operation: ");
      get(op);
      end loop;
   end makeTree;
end newWay;