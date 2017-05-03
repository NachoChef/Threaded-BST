with Ada.Sequential_IO;

generic
	type Akey is private;
	type BinarySearchTreeRecord is private;
	-- These functions compare two nodes in the tree.
	with function "<"(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord)
		return Boolean;  -- Is TheKey less than the key of ARecord?
	with function ">"(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) 
		return Boolean;
	with function "="(TheKey:  in Akey;  ARecord: in BinarySearchTreeRecord) 
		return Boolean;  --Is TheKey equal to the key of ARecord?
   with procedure myPutRec (ARecord : in BinarySearchTreeRecord);
   with procedure myPutName (Name : in AKey);
   with function getName (ARecord : in BinarySearchTreeRecord) return AKey;
   with function getNumber (ARecord : in BinarySearchTreeRecord) return AKey;
   with function makeRecord (P : in Akey; Q : in AKey) return BinarySearchTreeRecord;
package genericBST is
	type BinarySearchTreePoint is limited private;
   type nodeStack is array(Positive range <>) of BinarySearchTreePoint;
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
	procedure PreOrder(TreePoint: in out BinarySearchTreePoint; Root : in BinarySearchTreePoint);
	procedure PostOrderIterative(TreePoint: in out BinarySearchTreePoint);
	procedure PostOrderRecursive(TreePoint: in out BinarySearchTreePoint);
   procedure makeTree(file : String);
   type stack is array(Positive range <>) of BinarySearchTreeRecord;
   --procedure push(key : in BinarySearchTreePoint);
   --procedure pop(key : out BinarySearchTreePoint);
   
private
	type Node;
	type BinarySearchTreePoint is access Node;
	type Node is 
		record
			Llink, Rlink : BinarySearchTreePoint := null;
			Ltag, Rtag : Boolean := false;  -- True indicates pointer to lower level, False a thread.
			Info : BinarySearchTreeRecord;
		end record;
end genericBST;
