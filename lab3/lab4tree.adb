with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Tree is

type Node is
	record
		Data: Integer := 0;
		Left: access Node := null;
		Right: access Node := null;	
	end record;
	
type Node_Ptr is access all Node;

procedure Print_Tree(Tree: access Node) is
begin
	if Tree = null then null;
	elsif Tree.Left = null and Tree.Right = null then
		Put("(" & Tree.Data'Img & ")");
	else -- Tree.Left = null and Tree.Right = null then
		--New_line;	
		Put("(" );
		Print_Tree(Tree.Left);
		Put(Tree.Data'Img );
		Print_Tree(Tree.Right);
		Put(")");
	end if;

end;

procedure Tree_Insert(Tree: in out Node_Ptr; data: integer) is
	--N: Node_Ptr := new Node;
begin
	if Tree = null then Tree := new Node'(data,null,null);New_line;
	elsif Tree.Data = data then null;
	elsif data < Tree.Data then Tree_Insert(Tree.Left,data);
	elsif data > Tree.Data then Tree_Insert(Tree.Right,data);

	end if;	

end Tree_Insert;

tree : Node_Ptr := new Node'(5,null,null);
tree2 : Node_Ptr := new Node'(8,tree,null);
tree3 : Node_Ptr;

begin 
	Tree_Insert(tree3,10);
	Print_Tree(tree3);
	--Print_Tree(tree);
	--Print_Tree(tree2);
	Tree_Insert(tree2,10);
	Print_Tree(tree2);
	Tree_Insert(tree2,2);
	Print_Tree(tree2);	
	Tree_Insert(tree2,9);
	Print_Tree(tree2);
	Tree_Insert(tree2,7);
	Print_Tree(tree2);
	Tree_Insert(tree2,6);
	Print_Tree(tree2);
	Tree_Insert(tree2,4);
	Print_Tree(tree2);
null;
end Lab4Tree;
