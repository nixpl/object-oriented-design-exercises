program BubbleSort;

uses sysutils;

type
  TNumbers = array of Integer;

procedure GenerateRandomNumbers(var data: TNumbers);
var
  k: Integer;
begin
  SetLength(data, 50);
  for k := Low(data) to High(data) do
    data[k] := Random(101);
end;

var
  numberList: TNumbers;
  idx: Integer;
begin
  Randomize;
  
  GenerateRandomNumbers(numberList);
  
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn;
end.