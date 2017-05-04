package newWay is
   subtype String10 is String(1..10);
   type Node;
   type BinarySearchTreePoint is access Node;
   type Node is
      record
         LLink, RLink : BinarySearchTreePoint;
         LTag, RTag : boolean;
         custName, custPhone : String10;
      end record;
   procedure InsertBinarySearchTree(Root : in out BinarySearchTreePoint;
                                    custName : in String10; custPhone : in String10);
   procedure allocateNode(T : in out BinarySearchTreePoint; custName : String10; custNumber : String10);
   procedure insertNode (P : in out BinarySearchTreePoint; Q : in out BinarySearchTreePoint;
                        name : in String10; number : in String10);
   procedure FindCustIterative (Root : in out BinarySearchTreePoint; name : in String10;
                                custPoint : out BinarySearchTreePoint);
                                
   procedure makeTree;
   function InOrderSuccessor (TreePoint : in BinarySearchTreePoint) return BinarySearchTreePoint;
end newWay;