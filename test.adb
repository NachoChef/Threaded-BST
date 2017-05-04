with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure test is
   subtype String10 is String(1..10);
   t : String10 := "0000000002";
begin
   put(Integer'Value(t));
end test;