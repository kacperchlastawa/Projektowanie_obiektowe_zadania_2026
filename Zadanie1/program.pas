program BubbleSortProject;

uses sysutils;

type
    TIntArray = array of Integer;

procedure GenerateNumbers(var Arr: TIntArray; LowerBound, UpperBound, Amount: Integer);
var
    i: Integer;
begin
    SetLength(Arr, Amount);
    Randomize;
    for i := 0 to Amount - 1 do
        Arr[i] := Random(UpperBound - LowerBound + 1) + LowerBound;
end;

procedure BubbleSort(var Arr: TIntArray);
var
    i, j, temp, n: Integer;
begin
    n := Length(Arr);
    if n < 2 then exit;
    for i := 0 to n - 2 do
        for j := 0 to n - i - 2 do
            if Arr[j] > Arr[j + 1] then
            begin
                temp := Arr[j];
                Arr[j] := Arr[j + 1];
                Arr[j + 1] := temp;
            end;
end;

var
    MyArray: TIntArray;
    i: Integer;
begin
    Writeln('Generating 50 random numbers (0-100)...');
    GenerateNumbers(MyArray, 0, 100, 50);
    
    Writeln('Before sorting:');
    for i := 0 to High(MyArray) do Write(MyArray[i], ' ');
    Writeln;
    Writeln;

    Writeln('Sorting using Bubble Sort...');
    BubbleSort(MyArray);
    
    Writeln('Sorted result:');
    for i := 0 to High(MyArray) do
        Write(MyArray[i], ' ');
    Writeln;
end.