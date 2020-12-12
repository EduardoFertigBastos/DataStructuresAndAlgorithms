Program Pzim ;

type tipoDado = integer;
referencia = ^oElemento;
oElemento = record
  iDado:tipoDado;
  pAnt: referencia;
  pProx:referencia;
end;

type
oDecks = record
  pInicio				: referencia;
  pFim						: referencia;
end;

procedure inserirElemento(iNmr: tipoDado; iOpcao: integer; var oDeck: oDecks);
var pNew, pAux: referencia;
Begin
  new(pNew);
  if (pNew = nil) then
  begin
    write ('Memoria cheia! Limite atingido!');
    readkey;
  end
  else
  begin
    if (oDeck.pInicio = nil) then {Primeiro elemento}
    begin
      oDeck.pInicio:= pNew;
      oDeck.pFim:= pNew;
      
      pNew^.pProx:= nil;
      pNew^.pAnt:= nil;
    end
    else
    begin
      pAux:= oDeck.pInicio;
      
      {Inicio}
      if (iOpcao = 1) then
      begin
        pAux^.pAnt    := pNew;
        pNew^.pProx   := pAux;
        pNew^.pAnt    := nil;
        oDeck.pInicio := pNew;
      end
      else   {Fim}
      begin
        while (pAux^.pProx <> nil) do
        begin
          pAux:= pAux^.pProx;
        end;
        
        pAux^.pProx := pNew;
        pNew^.pAnt  := pAux;
        pNew^.pProx := nil;
        
        oDeck.pFim  := pNew;
      end;
    end;
    
    pNew^.iDado:= iNmr;
  end;
  writeln('------------------------------');
end;

procedure removerElemento(iOpcao: integer; var oDeck: oDecks);
var pAux, pAux2: referencia;
iCont, x: integer;
Begin
  if (oDeck.pInicio = nil) then
  begin
    Writeln('Deck Vazia!');
    readkey;
  end
  else
  Begin
    pAux:= oDeck.pInicio;
    pAux2:= oDeck.pInicio;
    
    if (pAux^.pProx = nil) then
    begin
      oDeck.pInicio:= nil;
      oDeck.pFim   := nil;
      
      dispose(pAux);
    end
    else
    begin
      if (iOpcao = 1) then
      begin
        oDeck.pInicio:= pAux^.pProx;
        pAux^.pProx^.pAnt:= nil;
        
        dispose(pAux);
      end
      else
      begin
        while (pAux2^.pProx <> nil) do
        begin
          pAux:= pAux2;
          pAux2:= pAux2^.pProx;
        end;
        
        pAux^.pProx:= nil;
        oDeck.pFim:= pAux;
        
        dispose(pAux2);
      end;
    end;
  end;
  writeln('------------------------------');
end;

procedure consultarDeck(iOpcao: integer; var oDeck: oDecks);
Begin
  if (oDeck.pInicio = nil) then
  begin
    writeln;
    writeln ('N�o tem nada para ser consultado na Deck!');
    writeln;
  end
  else
  begin
    writeln;
    if (iOpcao = 1) then
    begin
      writeln ('O n�mero encontrado foi: ', oDeck.pInicio^.iDado);
    end
    else
    begin
      writeln ('O n�mero encontrado foi: ', oDeck.pFim^.iDado);
    end;
    writeln;
  end;
  writeln('------------------------------');
end;

procedure imprimirDeck(var oDeck: oDecks);
var pAux:referencia;
iCont:integer;
Begin
  iCont:= 0;
  if (oDeck.pInicio = nil) then
  begin
    writeln('N�o tem nada pra imprimir na Deck!');
  end
  else
  Begin
    pAux:= oDeck.pInicio;
    writeln('// -> -> ->');
    while (pAux <> nil) do
    begin
      iCont:= iCont + 1;
      writeln('Posi��o: ', iCont,' - ',pAux^.iDado);
      pAux:= pAux^.pProx;
    end;
    writeln;
    writeln('// <- <- <-');
    
    pAux:= oDeck.pFim;;
    while (pAux <> nil) do
    begin
      writeln('Posi��o: ', iCont,' - ',pAux^.iDado);
      iCont:= iCont - 1;
      pAux:= pAux^.pAnt;
    end;;
  end;
end;

procedure declaracaoObjetos(var oDeck: oDecks);
begin
  oDeck.pInicio := nil;
  oDeck.pFim := nil;
end;

procedure mostrarMenu();
var iOpcao,iOp, x: integer;
oDeck: oDecks;
iNumero: tipoDado;
Begin
  for x:= 1 to 3 do
  declaracaoObjetos(oDeck);
  
  iOpcao:= 1;
  x		  := 1;
  iOp		:= 0;
  
  while (iOpcao <> 5) do
  begin
    writeln('Inserir(1)');
    writeln('Remover(2)');
    writeln('Consultar(3)');
    writeln('Imprimir(4)');
    writeln('Finalizar processo(5)');
    readln(iOpcao);
    
    if ((iOpcao <= 3) and(iOpcao >= 1)) then
    begin
      writeln('(1) Frente');
      writeln('(2) A tr�s');
      readln(iOp);
      
      while ((iOp <> 1) and (iOp <> 2)) do
      begin
        readln(iOp);
      end;
    end;
    
    if (iOpcao = 1) then
    begin
      writeln;
      writeln ('Digite o n�mero que deseja utilizar:');
      readln(iNumero);
      inserirElemento(iNumero, iOp, oDeck);
    end
    else if (iOpcao = 2) then
    removerElemento(iOp, oDeck)
    else if (iOpcao = 3) then
    consultarDeck(iOp, oDeck)
    else if (iOpcao = 4) then
    imprimirDeck(oDeck);
  end;
end;

Begin
  mostrarMenu();
End.
