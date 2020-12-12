Program Pzim ;

type tipoDado = integer;
referencia = ^oElemento;
oElemento = record
  iDado:tipoDado;
  pProx:referencia;
end;

type
oPilhas = record
  aPilha					: oElemento;
  pPonteiro			: referencia;
end;

procedure inserirElemento(iNmr: integer; var oPilha: oPilhas);
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
    if (oPilha.pPonteiro = nil) then {Primeiro elemento}
    begin
      pAux^.iDado:= iNmr;
      pAux^.pProx:= oPilha.pPonteiro;
      oPilha.pPonteiro:= pAux;
    end
    else
    begin {Inclui no Fim da Pilha}
      pAux2:= oPilha.pPonteiro;
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

procedure removerElemento(var oPilha: oPilhas);
var pAux, pAux2: referencia;
iCont, x: integer;
Begin
  if (oPilha.pPonteiro = nil) then
  begin
    Writeln('Pilha Vazia!');
    readkey;
  end
  else
  Begin
    pAux:= oPilha.pPonteiro;
    pAux2:= oPilha.pPonteiro;
    while (pAux2^.pProx <> nil) do
    begin
      pAux:= pAux2;
      pAux2:= pAux2^.pProx;
    end;
    if (pAux <> pAux2) then
    begin
      pAux^.pProx:= nil;
    end
    else
    begin
      oPilha.pPonteiro:= nil;
    end;
    dispose(pAux2);
  end;
  writeln('------------------------------');
end;

procedure consultarPilha(var oPilha: oPilhas);
var pAux: referencia;
Begin
  if (oPilha.pPonteiro = nil) then
  begin
    writeln;
    writeln ('Não tem nada para ser consultado na Pilha!');
    writeln;
  end
  else
  begin
    pAux:= oPilha.pPonteiro;
    while (pAux^.pProx <> nil) do
    begin
      pAux:= pAux^.pProx;
    end;
    writeln;
    writeln ('O número encontrado foi: ', pAux^.iDado);
    writeln;
  end;
  writeln('------------------------------');
end;

procedure imprimirPilha(var oPilha: oPilhas);
var pAux:referencia;
iCont:integer;
Begin
  iCont:= 0;
  if (oPilha.pPonteiro = nil) then
  begin
    writeln('Não tem nada pra imprimir na Pilha!');
  end
  else
  Begin
    pAux:= oPilha.pPonteiro;
    while (pAux <> nil) do
    begin
      iCont:= iCont + 1;
      writeln('Posição: ', iCont,' - ',pAux^.iDado);
      pAux:= pAux^.pProx;
    end;
  end;
end;

procedure declaracaoObjetos(var oPilha: oPilhas);
begin
  oPilha.pPonteiro := nil;
end;

procedure mostrarMenu();
var iOpcao, x, iNumero: integer;
oPilha: oPilhas;
Begin
  for x:= 1 to 3 do
  declaracaoObjetos(oPilha);
  
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
      inserirElemento(iNumero, oPilha);
    end
    else if (iOpcao = 2) then
    removerElemento(oPilha)
    else if (iOpcao = 3) then
    consultarPilha(oPilha)
    else if (iOpcao = 4) then
    imprimirPilha(oPilha);
  end;
end;

Begin
  mostrarMenu();
End.