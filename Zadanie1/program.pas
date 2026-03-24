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

procedure RunTests();
var
    TestArr: TIntArray;
    i: Integer;
    Sorted: Boolean;
begin
    Writeln('--- RUNNING UNIT TESTS ---');

    // Test 1: Check if the amount of generated numbers is correct
    GenerateNumbers(TestArr, 0, 10, 15);
    if Length(TestArr) = 15 then Writeln('Test 1 (Array Size): PASSED') 
    else Writeln('Test 1: FAILED');

    // Test 2: Check if generated numbers stay within the specified range
    if (TestArr[0] >= 0) and (TestArr[0] <= 10) then Writeln('Test 2 (Range): PASSED') 
    else Writeln('Test 2: FAILED');

    // Test 3: Verify if BubbleSort correctly sorts a reversed array
    SetLength(TestArr, 3);
    TestArr[0] := 30; TestArr[1] := 20; TestArr[2] := 10;
    BubbleSort(TestArr);
    if (TestArr[0] = 10) and (TestArr[1] = 20) and (TestArr[2] = 30) then Writeln('Test 3 (Reverse Sort): PASSED') 
    else Writeln('Test 3: FAILED');

    // Test 4: Check if the algorithm handles an array with identical values
    SetLength(TestArr, 2);
    TestArr[0] := 5; TestArr[1] := 5;
    BubbleSort(TestArr);
    if (TestArr[0] = 5) and (TestArr[1] = 5) then Writeln('Test 4 (Identical Values): PASSED') 
    else Writeln('Test 4: FAILED');

    // Test 5: Final check - verify order of a random sorted array
    GenerateNumbers(TestArr, 0, 50, 10);
    BubbleSort(TestArr);
    Sorted := True;
    for i := 0 to Length(TestArr) - 2 do
        if TestArr[i] > TestArr[i+1] then Sorted := False;
    if Sorted then Writeln('Test 5 (Sort Logic Verification): PASSED') 
    else Writeln('Test 5: FAILED');

    Writeln('--- TESTS COMPLETED ---');
    Writeln;
end;

var
    MyArray: TIntArray;
    i: Integer;
begin
    RunTests();

    Writeln('Main Program: Generating 50 random numbers (0-100)...');
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