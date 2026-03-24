program BubbleSortProject;

uses sysutils;

type
    TIntArray = array of Integer;

procedure GenerateNumbers(var Arr: TIntArray);
var
    i: Integer;
begin
    SetLength(Arr, 50);
    Randomize;
    for i := 0 to 49 do
        Arr[i] := Random(101);
end;

procedure BubbleSort(var Arr: TIntArray);
var
    i, j, temp, n: Integer;
begin
    n := Length(Arr);
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
    Writeln('Generating 50 random numbers...');
    GenerateNumbers(MyArray);
    
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