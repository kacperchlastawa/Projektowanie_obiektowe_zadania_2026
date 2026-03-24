program BubbleSortProject;

uses sysutils;

type
    TIntArray = array of Integer;

{ 3.0: Procedure to generate 50 random numbers from 0 to 100 }
procedure GenerateNumbers(var Arr: TIntArray);
var
    i: Integer;
begin
    SetLength(Arr, 50);
    Randomize;
    for i := 0 to 49 do
        Arr[i] := Random(101); { Random from 0 to 100 }
end;

var
    MyArray: TIntArray;
    i: Integer;
begin
    Writeln('Generating 50 random numbers:');
    GenerateNumbers(MyArray);
    
    for i := 0 to High(MyArray) do
        Write(MyArray[i], ' ');
    
    Writeln;
end.