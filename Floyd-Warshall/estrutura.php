<?php
function executamosOsCara(&$aDist, &$aCaminho, $iVertices)  
{      
    for ($k = 0; $k < $iVertices; $k++) {  
        for ($x = 0; $x < $iVertices; $x++) {  
            for ($y = 0; $y < $iVertices; $y++) {  
                if ($aDist[$x][$k] + $aDist[$k][$y] < $aDist[$x][$y]) {
                    
                    $aDist[$x][$y] = $aDist[$x][$k] + $aDist[$k][$y];
                    
                    $aCaminho[$x][$y] = $aCaminho[$x][$k] . '-' . $aCaminho[$k][$y];
                }  
            }  
       }  
    }      
}  
  
function imprimirMatriz($aDist, $aCaminho, $iInf, $iInicio, $iFim)  
{  
    echo '<br />';
    if ($aDist[$iInicio][$iFim] == $iInf) {
        echo 'Mesma Cidade de inicio e fim brother';
    } else {
        echo 'Custa ' . $aDist[$iInicio][$iFim] . 'L de gasolina e o caminho é: <br />';
        echo $aCaminho[$iInicio][$iFim];
    }    

}

function declararCidades(&$iInicio, &$iFim, $iVertices)
{
    if (($iInicio > $iVertices) or ($iInicio < 0)) {
        echo 'Cidades de origem existem somente entre 0 a 12, parceiro.';
    } else {
        $iInicio = $iInicio;    
    }

    if (($iFim > $iVertices) or ($iFim < 0)) {
        echo 'Cidades de destino existem somente entre 0 a 12, parceiro.';
    } else {
        $iFim = $iFim;    
    }
}

function declararInicioCaminhos(&$aCaminho)
{
    for ($x = 0; $x < 12; $x++) { 
        for ($y = 0; $y < 12; $y++) { 
            $aCaminho[$x][$y] = $x;
        }
    }
}

function declararFimCaminhos(&$aCaminho)
{
    for ($x = 0; $x < 12; $x++) { 
        for ($y = 0; $y < 12; $y++) { 
            $aCaminho[$x][$y] = $aCaminho[$x][$y] . '-' . $y;
        }
    }
}  
  
function matrizDistancia($aGrafo, $iInf)
{
    for ($x = 0; $x < 12; $x++) { 
        for ($y = 0; $y < 12; $y++) { 
            if ($x == $y) {
                $aDist[$x][$y] = 0;
            } else {
                if ($aGrafo[$x][$y] == 0) {
                    $aDist[$x][$y] = $iInf;
                } else {
                    $aDist[$x][$y] = $aGrafo[$x][$y];
                }
            }
        }
    }

    return $aDist;
}
        

 
  
?> 