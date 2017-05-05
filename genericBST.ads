--Justin Jones
--COSC 3319.01 Spring 2017
--Lab 5
--
--'A' Option

with Ada.Sequential_IO, Ada.Text_IO, Ada.Integer_Text_IO, gstack;
use Ada.Text_IO, Ada.Integer_Text_IO;

generic
	type Akey is private;
	type BinarySearchTreeRecord is private;
	with function "<"(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord)
		return Boolean;  -- Is TheKey less than the key of ARecord?
	with function ">"(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) 
		return Boolean;
	with function "="(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) 
		return Boolean;  --Is TheKey equal to the key of ARecord?
   with procedure myPutRec (ARecord : in BinarySearchTreeRecord);
   with procedure myPutName (Name : in AKey);
   with function getName (ARecord : in BinarySearchTreeRecord) 
      return AKey;
   with function makeRecord (P : in Akey; Q : in AKey) 
      return BinarySearchTreeRecord;
   with function getVal (P : in AKey) return Integer;
   dummy : AKey;
package genericBST is
	type BinarySearchTreePoint is limited private;
   package KeyIO is new Ada.Sequential_IO(AKey);
   use KeyIO;
	procedure InsertBinarySearchTree(Root:  in out BinarySearchTreePoint;
				          custName: in AKey; custPhone: AKey );
	procedure FindCustomerIterative(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint);
	procedure FindCustomerRecursive(Root: in BinarySearchTreePoint; 
				          CustomerName:  in AKey;
				          CustomerPoint:  out BinarySearchTreePoint);
	function InOrderSuccessor(TreePoint: in BinarySearchTreePoint) 
		return BinarySearchTreePoint;
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint; 
                     Root : in BinarySearchTreePoint);
	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint);
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint);
   procedure makeTree(file : String);
   procedure allocateNode (Q : out BinarySearchTreePoint; 
                           name: in AKey; number : in AKey);
   procedure insertNode (P : in out BinarySearchTreePoint; 
                        Q : in out BinarySearchTreePoint; name : in Akey; 
                        number : IN Akey);
   procedure ReverseInOrder (P : in out BinarySearchTreePoint);
   procedure DeleteRandomNode(Q : in out BinarySearchTreePoint; 
                              Root : in out BinarySearchTreePoint);
private
	type Node;
	type BinarySearchTreePoint is access Node;
	type Node is 
		record
			Llink, Rlink : BinarySearchTreePoint := null;
			Ltag, Rtag : Boolean := false; 
			Info : BinarySearchTreeRecord;
		end record;
   type stackRec is
      record
         num : Integer;
         point : BinarySearchTreePoint;
      end record;
end genericBST;
