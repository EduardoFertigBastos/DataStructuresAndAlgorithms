Program Pzim ;

type tipoDado = integer;
referencia = ^oNoModelo;
oNoModelo = record
  iDado:tipoDado;
  pEsq:referencia;
  pDir:referencia;
end;

type
oArvore = record
  pRaiz					: referencia;
  iTamanho				: integer;
end;

procedure inserirDireita(var oNo: referencia; iNmr: integer);forward;

procedure inserirEsquerda(var oNo: referencia; iNmr: integer);
var pAux: referencia;
Begin
  // Nó nulo
  if (oNo^.pEsq = nil) then
  begin
    new(pAux);
    pAux^.iDado:= iNmr;
    pAux^.pEsq := nil;
    pAux^.pDir := nil;
    
    oNo^.pEsq  := pAux;
  end
  else
  begin
    if (iNmr < oNo^.pEsq^.iDado) then
    begin
      inserirEsquerda(oNo^.pEsq, iNmr);
    end;
    
    if (iNmr > oNo^.pEsq^.iDado) then
    begin
      inserirDireita(oNo^.pEsq, iNmr);
    end;
  end;
end;

procedure inserirDireita(var oNo: referencia; iNmr: integer);
var pAux: referencia;
Begin
  // Nó nulo
  if (oNo^.pDir = nil) then
  begin
    new(pAux);
    pAux^.iDado:= iNmr;
    pAux^.pEsq := nil;
    pAux^.pDir := nil;
    
    oNo^.pDir  := pAux;
  end
  else
  begin
    if (iNmr > oNo^.pDir^.iDado) then
    begin
      inserirDireita(oNo^.pDir, iNmr);
    end;
    
    if (iNmr < oNo^.pDir^.iDado) then
    begin
      inserirEsquerda(oNo^.pDir, iNmr);
    end;
  end;
end;

procedure inserir(var oArv: oArvore; iNmr: integer);
var pAux: referencia;
begin
  //Raiz Nula
  if (oArv.pRaiz = nil) then
  begin
    new(pAux);
    pAux^.iDado:= iNmr;
    pAux^.pEsq := nil;
    pAux^.pDir := nil;
    
    oArv.pRaiz  := pAux;
  end
  else
  begin
    if (iNmr < oArv.pRaiz^.iDado) then
    begin
      inserirEsquerda(oArv.pRaiz, iNmr);
    end;
    
    if (iNmr > oArv.pRaiz^.iDado) then
    begin
      inserirDireita(oArv.pRaiz, iNmr);
    end;
  end;
  
end;

procedure imprimir(var oNo: referencia; iForma: integer);
begin
  if (oNo <> nil) then
  begin
    if (iForma = 1) then
    begin
      writeln(oNo^.iDado);
      imprimir(oNo^.pEsq, 1);
      imprimir(oNo^.pDir, 1);
    end
    else if (iForma = 2) then
    begin
      imprimir(oNo^.pEsq, 2);
      writeln(oNo^.iDado);
      imprimir(oNo^.pDir, 2);
    end
    else if (iForma = 3) then
    begin
      imprimir(oNo^.pEsq, 3);
      imprimir(oNo^.pDir, 3);
      writeln(oNo^.iDado);
    end
  end;
end;

function consultar(var oNo: referencia; iNmr: integer): boolean;
begin
  if (oNo = nil) then
  begin
    consultar:= false;
  end
  else
  begin
    if (oNo^.iDado = iNmr) then
    begin
      consultar:= true;
    end
    else
    begin
      if (iNmr < oNo^.iDado) then
      begin
        consultar:= consultar(oNo^.pEsq, iNmr);
      end
      else
      begin
        consultar:= consultar(oNo^.pDir, iNmr);
      end;
    end;
  end;
end;

function descobrirPosicao(var oNo: referencia; iNmr: integer): referencia;
var x: integer;
begin
  if (oNo = nil) then
  begin
    descobrirPosicao:= nil;
  end
  else
  begin
    if (oNo^.iDado = iNmr) then
    begin
      descobrirPosicao:= oNo;
    end
    else
    begin
      if (iNmr < oNo^.iDado) then
      begin
        descobrirPosicao:= descobrirPosicao(oNo^.pEsq, iNmr);
      end
      else
      begin
        descobrirPosicao:= descobrirPosicao(oNo^.pDir, iNmr);
      end;
    end;
  end;
end;

function tamanho(var oNo: referencia): integer;
var x: integer;
begin
  if (oNo = nil) then
  begin
    tamanho:= 0;
  end
  else
  begin
    tamanho:= 1 + tamanho(oNo^.pEsq) + tamanho(oNo^.pDir);
  end;
end;

function nivel(var oNo: referencia; iNmr: integer; bSim: boolean): integer;
begin
  if (bSim = true) then
  begin
    if (oNo = nil) then
    begin
      nivel:= 0;
    end
    else
    begin
      if (iNmr < oNo^.iDado) then
      begin
        nivel:= nivel(oNo^.pEsq, iNmr, bSim) + 1;
      end
      else if (iNmr > oNo^.iDado) then
      begin
        nivel:= nivel(oNo^.pDir, iNmr, bSim) + 1;
      end;
    end;
  end
  else
  begin
    nivel:= -1;
  end;
  
end;

function altura(var oNo: referencia): integer;
var iEsq, iDir: integer;
begin
  if (oNo = nil) then
  begin
    altura:= 0;
  end
  else
  begin
    iEsq:= altura(oNo^.pEsq);
    iDir:= altura(oNo^.pDir);
    
    if (iEsq > iDir) then
    begin
      altura:= iEsq + 1;
    end
    else
    begin
      altura:= iDir + 1;
    end;
  end;
end;

function completa(iAltura, iTam: integer): boolean;
var x, iAlt: integer;
begin
  iAlt:= 1;
  for x:= 1 to iAltura do
  begin
    iAlt:= iAlt * 2;
  end;
  
  if (iAlt - 1 = iTam) then
  begin
    completa:= true;
  end
  else
  begin
    completa:= false;
  end;
end;

function remover(var oNo: referencia; iNmr: integer): referencia;
var pAux: referencia;
begin
  // Nó nulo
  if (oNo = nil) then
  begin
    writeln('Valor não encontrado');
    remover:= nil;
  end
  else
  begin
    if (oNo^.iDado = iNmr) then
    begin
      // Nós folhas
      if ((oNo^.pEsq = nil) and (oNo^.pDir = nil))then
      begin
        dispose(oNo);
        remover:= nil;
      end
      else
      begin
        // Nós com um filho
        if ((oNo^.pEsq = nil) or (oNo^.pDir = nil)) then
        begin
          if (oNo^.pEsq <> nil) then
          begin
            pAux:= oNo^.pEsq;
          end
          else
          begin
            pAux:= oNo^.pDir;
          end;
          
          dispose(oNo);
          remover:= pAux;
        end
        else
        begin
          // Nós com 2 filhos
          pAux:= oNo^.pEsq;
          
          while (pAux^.pDir <> nil) do
          begin
            pAux:= pAux^.pDir
          end;
          
          oNo^.iDado := pAux^.iDado;
          pAux^.iDado:= iNmr;
          oNo^.pEsq	 := remover(oNo^.pEsq, iNmr);
          remover		 := oNo;
        end;
      end
    end
    else
    begin
      if (iNmr < oNo^.idado) then
      begin
        oNo^.pEsq:= remover(oNo^.pEsq, iNmr);
      end
      else
      begin
        oNo^.pDir:= remover(oNo^.pDir, iNmr);
      end;
      remover:= oNo;
    end;
  end;
end;

procedure mostrarMenu();
var iOpcao, iImp, iResult, x, iNumero: integer;
oArv: oArvore;
Begin
  iOpcao				:= 1;
  oArv.pRaiz		:= nil;
  oArv.iTamanho	:= 0;
  
  {
  b) Percorrer Pré, In e Pós Ordem
  
  f) Informar se a árvore está completa ou não
  }
  while (iOpcao <> 8) do
  begin
    writeln;
    writeln('Inserir(1)');
    writeln('Remover(2)');
    writeln('Consultar Elemento (3)');
    writeln('Informar Altura (4)');
    writeln('Informar Nível de um Elemento (5)');
    writeln('Informar se a árvore está Completa (6)');
    writeln('Imprimir(7)');
    writeln('Finalizar processo(8)');
    readln(iOpcao);
    
    if (iOpcao = 1) then
    begin
      writeln;
      writeln ('Digite o número que deseja inserir:');
      readln(iNumero);
      inserir(oArv, iNumero);
    end
    
    else if (iOpcao = 2) then
    begin
      writeln;
      writeln ('Digite o número que deseja remover:');
      readln(iNumero);
      oArv.pRaiz:= remover(oArv.pRaiz, iNumero);
    end
    
    else if (iOpcao = 3) then
    begin
      writeln;
      writeln ('Digite o número que deseja consultar:');
      readln(iNumero);
      if (consultar(oArv.pRaiz, iNumero)) then
      begin
        writeln('O número existe na árvore.');
      end
      else
      begin
        writeln('O número não existe na árvore.');
      end;
    end
    
    else if (iOpcao = 4) then
    begin
      iResult:= altura(oArv.pRaiz);
      if (iResult <> 0) then
      begin
        writeln('Altura: ', iResult);
      end
      else
      begin
        writeln('Árvore sem altura.');
      end;
    end
    
    else if (iOpcao = 5) then
    begin
      writeln;
      writeln ('Digite o número que deseja consultar o nível:');
      readln(iNumero);
      
      iResult:= nivel(oArv.pRaiz, iNumero, consultar(oArv.pRaiz, iNumero));
      if (iResult <> -1) then
      begin
        writeln('Nível: ', iResult + 1);
      end
      else
      begin
        writeln('o Número ', iNumero, ' não existe na árvore, portanto não possui nível.');
      end;
      
    end
    
    else if (iOpcao = 6) then
    if (completa(altura(oArv.pRaiz), tamanho(oArv.pRaiz))) then
    begin
      writeln('A árvore está completa');
    end
    else
    begin
      writeln('A árvore não está completa');
    end
    
    else if (iOpcao = 7) then
    begin
      writeln;
      writeln ('Pré-Ordem (1)');
      writeln ('In-Ordem (2)');
      writeln ('Pós-Ordem (3)');
      writeln;
      readln(iImp);
      
      if (oArv.pRaiz <> nil) then
      begin
        imprimir(oArv.pRaiz, iImp);
      end
      else
      begin
        writeln('Não há nada para imprimir');
      end
      
    end;
  end;
end;

Begin
  mostrarMenu();
End.