Program Pzim ;
type typeArray = array[1..10] of integer;

procedure methodQuicksort(iInicio, iFim : integer; var aVetor: typeArray);
var iNewStart, iNewEnd, iPivot, iAux : integer;
begin
  iNewStart := iInicio;
iNewEnd		:= iFim;
iPivot 		:= aVetor[(iNewStart + iNewEnd) div 2];

while (iNewStart <= iNewEnd) do
begin
  while (aVetor[iNewStart] < iPivot) and (iNewStart < iFim) do
  begin
    iNewStart:= iNewStart + 1;
  end;
  
while (aVetor[iNewEnd] > iPivot) and (iNewEnd > iInicio) do
begin
iNewEnd:= iNewEnd - 1;
end;

if (iNewStart <= iNewEnd) then
begin
  iAux 						 	:= aVetor[iNewStart];
aVetor[iNewStart]	:= aVetor[iNewEnd];
aVetor[iNewEnd]  	:= iAux;
iNewStart 			 	:= iNewStart + 1;
iNewEnd						:= iNewEnd - 1;
end;
end;

if (iNewEnd > iInicio) then
begin
methodQuicksort(iInicio, iNewEnd, aVetor);
end;

if (iNewStart < iFim) then
begin
  methodQuicksort(iNewStart, iFim, aVetor);
end;
end;

procedure createArray(var aArray: typeArray);
var x: integer;
begin
  randomize;
  for x:= 1 to 10 do
  begin
    aArray[x] := random(100)+1;
  end;
end;

procedure showArray(aArray: typeArray);
var x: integer;
begin
  for x:= 1 to 10 do
  begin
    write(aArray[x], ' ');
  end;
  writeln;
end;

var aVetor: typeArray;
iStart, iEnd: integer;

begin
  createArray(aVetor);
  iStart:= 1;
iEnd:= 10;

writeln('Vetor desordenado:');
showArray(aVetor);
writeln;

methodQuicksort(iStart, iEnd, aVetor);

writeln('Vetor ordenado:');
showArray(aVetor);
end.