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

procedure PerformBubbleSort(var data: TNumbers);
var
  x, y, tempVal, dataLen: Integer;
begin
  dataLen := Length(data);
  if dataLen <= 1 then Exit;
  
  for x := 0 to dataLen - 2 do
  begin
    for y := 0 to dataLen - x - 2 do
    begin
      if data[y] > data[y + 1] then
      begin
        tempVal := data[y];
        data[y] := data[y + 1];
        data[y + 1] := tempVal;
      end;
    end;
  end;
end;

var
  numberList: TNumbers;
  idx: Integer;
begin
  Randomize;
  
  GenerateRandomNumbers(numberList);
  
  WriteLn('raw:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn; WriteLn;
  
  PerformBubbleSort(numberList);
  
  WriteLn('sorted:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn;
end.