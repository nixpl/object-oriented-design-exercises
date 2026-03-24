program BubbleSort;

uses sysutils;

type
  TNumbers = array of Integer;

procedure GenerateRandomNumbers(var data: TNumbers; rangeFrom, rangeTo, amount: Integer);
var
  k: Integer;
begin
  if amount < 0 then amount := 0;
  SetLength(data, amount);
  
  for k := Low(data) to High(data) do
  begin
    data[k] := rangeFrom + Random(rangeTo - rangeFrom + 1);
  end;
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
  
  GenerateRandomNumbers(numberList, 0, 100, 50);
  
  WriteLn('raw:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn; WriteLn;
  
  PerformBubbleSort(numberList);
  
  WriteLn('sorted:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn;
end.