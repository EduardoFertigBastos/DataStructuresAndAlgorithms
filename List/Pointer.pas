Program Pzim ;

type tipoDado = string;
referencia = ^oElemento;
oElemento = record
  sPort:tipoDado;
  sIng:tipoDado;
  pAnt: referencia;
  pProx:referencia;
end;

type
oListas = record
  pInicio				: referencia;
  pFim						: referencia;
end;

procedure inserirElemento(sPalavra, sWord: tipoDado; var oLista: oListas);
var pNew, pAux, pAux2: referencia;
Begin
  new(pNew);
  
  sPalavra:= upcase(sPalavra);
    sWord:= upcase(sWord);
      if (pNew = nil) then
      begin
        write ('Memoria cheia! Limite atingido!');
        readkey;
      end
      else
      begin
        if (oLista.pInicio = nil) then {Primeiro elemento}
        begin
          pNew^.sPort			:= sPalavra;
          pNew^.sIng			:= sWord;
          pNew^.pAnt			:= nil;
          pNew^.pProx			:= nil;
          
          oLista.pInicio		:= pNew;
          oLista.pFim			:= pNew;
        end
        else
        begin
          pAux := oLista.pInicio;
          pAux2:= oLista.pInicio;
          
          while ((pAux^.pProx <> nil) and (pAux2^.sPort < sPalavra)) do
          begin
            pAux:= pAux2;
            pAux2:= pAux2^.pProx;
          end;
          
          if (sPalavra < oLista.pInicio^.sPort) then
          begin
            pNew^.sPort:= sPalavra;
            pNew^.sIng := sWord;
            pNew^.pProx:= pAux;
            pNew^.pAnt := nil;
            
            pAux^.pAnt:= pNew;
            oLista.pInicio:= pNew;
          end
          else
          begin
            if ((pAux^.pProx = nil) and (pAux^.sPort < sPalavra)) then
            begin
              pNew^.sPort:= sPalavra;
              pNew^.sIng := sWord;
              pNew^.pProx:= nil;
              pNew^.pAnt := pAux;
              
              pAux^.pProx:= pNew;
              oLista.pFim := pNew
            end
            else
            begin
              pNew^.sPort:= sPalavra;
              pNew^.sIng := sWord;
              pNew^.pAnt := pAux;
              pNew^.pProx:= pAux2;
              
              pAux^.pProx:= pNew;
              pAux2^.pAnt:= pNew;
            end
          end;
        end;
      end;
      
      writeln('------------------------------');
    end;
    
    procedure removerElemento(sPalavra: tipoDado; var oLista: oListas);
    var pAux, pAux2: referencia;
    iCont, x: integer;
    bOpcao: boolean;
    Begin
      if (oLista.pInicio = nil) then
      begin
        Writeln('Lista Vazia!');
        readkey;
      end
      else
      Begin
        sPalavra:= upcase(sPalavra);
          pAux:= oLista.pInicio;
          pAux2:= oLista.pInicio;
          bOpcao:= false;
          
          while ((pAux2^.sPort <> sPalavra) and (bOpcao = false)) do
          begin
            pAux:= pAux2;
            pAux2:= pAux2^.pProx;
            if (pAux^.pProx = nil) then
            begin
              bOpcao:= true;
            end;
          end;
          
          if (bOpcao = false) then
          begin
            if (pAux2^.pProx = nil) then
            begin
              if (pAux <> pAux2) then
              begin
                // Ultimo
                pAux^.pProx:= nil;
                oLista.pFim:= pAux;
              end
              else
              begin
                // Tudo
                oLista.pInicio:= nil;
                oLista.pFim:= nil;
              end;
            end
            else
            begin
              if (pAux^.pProx <> nil) then
              begin
                if (pAux <> pAux2) then
                begin
                  // Meio
                  pAux2^.pProx^.pAnt:= pAux;
                  pAux^.pProx:= pAux2^.pProx;
                  
                end
                else
                begin
                  // Primeiro
                  oLista.pInicio:= pAux^.pProx;
                  pAux^.pProx^.pAnt:= nil;
                end;
              end;
            end;
          end
          else
          begin
            writeln('Elemento indisponível para remoção');
          end;
          
          dispose(pAux2);
        end;
        writeln('------------------------------');
      end;
      
      procedure consultarLista(sPalavra: tipoDado; var oLista: oListas);
      var pAux, pAux2: referencia;
      bOpcao: boolean;
      Begin
        if (oLista.pInicio = nil) then
        begin
          writeln;
          writeln ('Não tem nada para ser consultado na lista!');
          writeln;
        end
        else
        begin
          sPalavra:= upcase(sPalavra);
            pAux:= oLista.pInicio;
            pAux2:= oLista.pInicio;
            bOpcao:= false;
            
            while ((pAux2^.sPort <> sPalavra) and (bOpcao = false)) do
            begin
              pAux:= pAux2;
              pAux2:= pAux2^.pProx;
              if (pAux^.pProx = nil) then
              begin
                bOpcao:= true;
              end;
            end;
            
            if (bOpcao = false) then
            begin
              writeln;
              writeln ('A palavra [PORT]: ', pAux2^.sPort, ' - [ING]: ', pAux2^.sIng, ' foi encontrada');
              writeln;
            end
            else
            begin
              writeln;
              writeln ('Impossível realizar a consulta. Elemento não cadastrado.');
              writeln;
            end;
          end;
          writeln('------------------------------');
        end;
        
        procedure imprimirLista(var oLista: oListas);
        var pAux:referencia;
        iCont:integer;
        Begin
          iCont:= 0;
          
          if (oLista.pInicio = nil) then
          begin
            writeln('Não tem nada pra imprimir na lista!');
          end
          else
          Begin
            pAux:= oLista.pInicio;
            
            while (pAux <> nil) do
            begin
              iCont:= iCont + 1;
              writeln('Posição: ', iCont,' - Port: ', pAux^.sPort, ' - Ing: ', pAux^.sIng);
              pAux:= pAux^.pProx;
            end;
            
            writeln ('----------------------------------------------------');
            
            pAux:= oLista.pFim;
            iCont:= iCont + 1;
            
            while (pAux <> nil) do
            begin
              iCont:= iCont - 1;
              writeln('Posição: ', iCont,' - Port: ', pAux^.sPort, ' - Ing: ', pAux^.sIng);
              pAux:= pAux^.pAnt;
            end;
          end;
        end;
        
        procedure declaracaoObjetos(var oLista: oListas);
        begin
          oLista.pInicio := nil;
          oLista.pFim 	 := nil;
        end;
        
        procedure mostrarMenu();
        var iOpcao, x: integer;
        sPalavra, sWord: tipoDado;
        oLista: oListas;
        Begin
          for x:= 1 to 3 do
          declaracaoObjetos(oLista);
          
          iOpcao:= 1;
          x:= 1;
          
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
              writeln ('[PORT] Digite a palavra que deseja inserir:');
              readln(sPalavra);
              writeln ('[ING] Digite a palavra que deseja inserir:');
              readln(sWord);
              inserirElemento(sPalavra, sWord, oLista);
            end
            else if (iOpcao = 2) then
            begin
              writeln;
              writeln ('Digite o número que deseja utilizar:');
              readln(sPalavra);
              removerElemento(sPalavra, oLista);
            end
            else if (iOpcao = 3) then
            begin
              writeln;
              writeln ('Digite o número que deseja utilizar:');
              readln(sPalavra);
              consultarLista(sPalavra, oLista);
            end
            else if (iOpcao = 4) then
            imprimirLista(oLista);
          end;
        end;
        
        Begin
          mostrarMenu();
        End.