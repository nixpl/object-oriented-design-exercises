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

procedure RunUnitTests;
var
  testData: TNumbers;
  idx: Integer;
  isValid: Boolean;
begin
  WriteLn('running tests...');

  GenerateRandomNumbers(testData, 0, 100, 50);
  if Length(testData) = 50 then WriteLn('t1 (len=50): pass') else WriteLn('t1: fail');

  isValid := True;
  for idx := Low(testData) to High(testData) do
    if (testData[idx] < 0) or (testData[idx] > 100) then isValid := False;
  if isValid then WriteLn('t2 (0-100 range): pass') else WriteLn('t2: fail');

  PerformBubbleSort(testData);
  isValid := True;
  for idx := Low(testData) to High(testData) - 1 do
    if testData[idx] > testData[idx + 1] then isValid := False;
  if isValid then WriteLn('t3 (sorting logic): pass') else WriteLn('t3: fail');

  GenerateRandomNumbers(testData, -100, -10, 15);
  PerformBubbleSort(testData);
  isValid := True;
  for idx := Low(testData) to High(testData) - 1 do
    if testData[idx] > testData[idx + 1] then isValid := False;
  if isValid then WriteLn('t4 (negative values): pass') else WriteLn('t4: fail');

  GenerateRandomNumbers(testData, 0, 50, 0);
  PerformBubbleSort(testData);
  if Length(testData) = 0 then WriteLn('t5 (empty array): pass') else WriteLn('t5: fail');

  WriteLn('tests done.');
  WriteLn;
end;

var
  numberList: TNumbers;
  idx: Integer;
begin
  Randomize;
  
  RunUnitTests;

  WriteLn('main run:');
  GenerateRandomNumbers(numberList, 0, 100, 50);

  WriteLn('raw:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn; WriteLn;

  PerformBubbleSort(numberList);

  WriteLn('sorted:');
  for idx := Low(numberList) to High(numberList) do Write(numberList[idx], ' ');
  WriteLn;
end.