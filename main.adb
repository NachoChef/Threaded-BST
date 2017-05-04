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
   
   function getVal (P : in String10) return Integer is
   begin
      return Integer'Value(P);
   end getVal;
   
   head : String(1..10) := "zzzzzzzzzz";
   
   package myBST is new genericBST(String10, Customer,"<", ">", "=", myPutRec, myPutName, getName, getNumber, makeRecord, getVal, head);
begin
      myBST.makeTree("input.txt");
end main;