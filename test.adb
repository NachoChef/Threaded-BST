with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with newWay; use newWay;

procedure test is
   subtype String10 is String(1..10);
   t : String10 := "0000000002";
begin
   makeTree;
end test;