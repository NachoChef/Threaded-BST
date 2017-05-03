with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
with genericBST;

procedure main is
   subtype String10 is String(1..10);
	type Customer is record 
      Name:  String10;
      PhoneNumber: String10;
   end record;
   
   function "<"(TheKey:  in String10;  ARecord: in Customer) return Boolean is
   begin
      return (TheKey < ARecord.Name);
   end "<";   
   
   function ">"(TheKey:  in String10;  ARecord: in Customer) return Boolean is
   begin
      return (TheKey > ARecord.Name);
   end ">";
   
   function "="(TheKey:  in String10;  ARecord: in Customer) return Boolean is
   begin
      return (TheKey = ARecord.Name);
   end "=";
   
   procedure myPutRec (ARecord : in Customer) is
   begin
      put(ARecord.Name); put(" -- "); put(ARecord.PhoneNumber); New_Line;
   end myPutRec;
   
   procedure myPutName (Name : in String10) is
   begin
      put(Name);
   end myPutName;
   
   function getName (ARecord : in Customer) return String10 is
   begin
      return ARecord.Name;
   end getName;
   
   function getNumber (ARecord : in Customer) return String10 is
   begin
      return ARecord.PhoneNumber;
   end getNumber;
   
   function makeRecord (P : in String10; Q : in String10) return Customer is
      rec : Customer := (P, Q);
   begin
      return rec;
   end makeRecord;
   
   package myBST is new genericBST(String10, Customer,"<", ">", "=", myPutRec, myPutName, getName, getNumber, makeRecord);
begin
--    put_line("1 : Insert // 2 : Search Iterative // 3 : Search Recursive");
--    put_line("4 : Traverse Inorder // 5 : Traverse Inorder, Root");
--    put_line("6 : Delete, Binary Search // 7 : Reverse Inorder, Root");
--    put_line("8 : Traverse Preorder, Iterative // 9 : Traverse Postorder, Iterative");
    put_line("10 : Traverse Postorder, Recursive");
   
       
end main;