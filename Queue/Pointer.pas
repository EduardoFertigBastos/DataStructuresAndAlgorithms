Program Pzim ;

type tipoDado = integer;
referencia = ^oElemento;
oElemento = record
  iDado:tipoDado;
  pProx:referencia;
end;

type
oFilas = record
  aFila					: oElemento;
  pPonteiro			: referencia;
end;

procedure inserirElemento(iNmr: integer; var oFila: oFilas);
var pAux, pAux2: referencia;
Begin
  new(pAux);
  if (pAux = nil) then
  begin
    write ('Memoria cheia! Limite atingido!');
    readkey;
  end
  else
  begin
    if (oFila.pPonteiro = nil) then {Primeiro elemento}
    begin
      pAux^.iDado:= iNmr;
      pAux^.pProx:= oFila.pPonteiro;
      oFila.pPonteiro:= pAux;
    end
    else
    begin {Inclui no Fim da Fila}
      pAux2:= oFila.pPonteiro;
      while (pAux2^.pProx <> nil) do
      begin
        pAux2:= pAux2^.pProx;
      end;
      pAux^.iDado:= iNmr;
      pAux^.pProx:= nil;
      pAux2^.pProx:= pAux;
    end;
  end;
  
  writeln('------------------------------');
end;

procedure removerElemento(var oFila: oFilas);
var pAux: referencia;
Begin
  if (oFila.pPonteiro = nil) then
  begin
    Writeln('Fila Vazia!');
    readkey;
  end
  else
  Begin
    pAux:= oFila.pPonteiro;
    Writeln('Elemento retirado: ', pAux^.iDado);
    oFila.pPonteiro:= pAux^.pProx;
    dispose(pAux);
    readkey;
  end;
  writeln('------------------------------');
end;

procedure consultarFila(var oFila: oFilas);
Begin
  if (oFila.pPonteiro = nil) then
  begin
    writeln;
    writeln ('Não tem nada para ser consultado na fila!');
    writeln;
  end
  else
  begin
    writeln;
    writeln ('O número encontrado foi: ', oFila.pPonteiro^.iDado);
    writeln;
  end;
  writeln('------------------------------');
end;

procedure imprimirFila(var oFila: oFilas);
var pAux:referencia;
iCont:integer;
Begin
  iCont:= 0;
  if (oFila.pPonteiro = nil) then
  begin
    writeln('Não tem nada pra imprimir na fila!');
  end
  else
  Begin
    pAux:= oFila.pPonteiro;
    while (pAux <> nil) do
    begin
      iCont:= iCont + 1;
      writeln('Posição: ', iCont,' - ',pAux^.iDado);
      pAux:= pAux^.pProx;
    end;
  end;
end;

procedure declaracaoObjetos(var oFila:oFilas);
begin
  oFila.pPonteiro := nil;
end;

procedure mostrarMenu();
var iOpcao, x, iNumero: integer;
oFila: oFilas;
Begin
  for x:= 1 to 3 do
  declaracaoObjetos(oFila);
  
  iOpcao:= 1;
  
  while (iOpcao <> 5) do
  begin
    writeln('Inserir(1)');
    writeln('Remover(2)');
    writeln('Consultar(3)');
    writeln('Imprimir(4)');
    writeln('Finalizar processo(5)');
    readln(iOpcao);
    
    if (iOpcao = 1) then
    begin
      writeln;
      writeln ('Digite o número que deseja utilizar:');
      readln(iNumero);
      inserirElemento(iNumero, oFila);
    end
    else if (iOpcao = 2) then
    removerElemento(oFila)
    else if (iOpcao = 3) then
    consultarFila(oFila)
    else if (iOpcao = 4) then
    imprimirFila(oFila);
  end;
end;

Begin
  mostrarMenu();
End.