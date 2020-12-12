<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CAIXEIRO DA DESGRAÇA</title>
    <style>
        body {
            font-size: 20px;
        }
    </style>
</head>
<body>
    
    <form method="GET" action="index.php">

        <label for="inicio">Origem:</label>
        <input type="number" name="inicio" id="inicio">    

        <br />

        <label for="fim">Destino:</label>
        <input type="number" name="fim" id="fim">

        <br />
        <input type="submit" value="Enviar">
    
    </form>
    <?php
        require_once 'estrutura.php';

        $aGrafo = [
            [0, 3, 0, 0, 0, 0, 0, 0, 0, 5, 0, 9],
            [3, 0, 4, 0, 0, 0, 0, 0, 0, 0, 5, 0],
            [0, 4, 0, 3, 0, 0, 0, 0, 0, 0, 6, 0],
            [0, 0, 3, 0, 4, 0, 0, 0, 0, 0, 0, 9],
            [0, 0, 0, 4, 0, 5, 0, 0, 0, 0, 0, 8],
            [0, 0, 0, 0, 5, 0, 4, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 4, 0, 2, 0, 0, 0, 3],
            [0, 0, 0, 0, 0, 0, 2, 0, 4, 0, 0, 5],
            [0, 0, 0, 0, 0, 0, 0, 4, 0, 6, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 7],
            [0, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [9, 0, 0, 9, 8, 0, 3, 5, 0, 7, 0, 0],
        ];
                
            /*  [
            [    0,     3, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     5, $iInf,     9],
            [    3,     0,     4, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     5, $iInf],
            [$iInf,     4,     0,     3, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     6, $iInf],
            [$iInf, $iInf,     3,     0,     4, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     9],
            [$iInf, $iInf, $iInf,     4,     0,     5, $iInf, $iInf, $iInf, $iInf, $iInf,     8],
            [$iInf, $iInf, $iInf, $iInf,     5,     0,     4, $iInf, $iInf, $iInf, $iInf, $iInf],
            [$iInf, $iInf, $iInf, $iInf, $iInf,     4,     0,     2, $iInf, $iInf, $iInf,     3],
            [$iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     2,     0,     4, $iInf, $iInf,     5],
            [$iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     4,     0,     6, $iInf, $iInf],
            [$iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     6,     0, $iInf,     7],
            [$iInf,     5,     6, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf, $iInf,     0, $iInf],
            [    9, $iInf, $iInf,     9,     8, $iInf,     3,     5, $iInf,     7, $iInf,     0], 
        ]; */
        
        $iVertices  = 12; 
        $iInf       = 99999;
        $aDist      = matrizDistancia($aGrafo, $iInf);
        $iInicio    = $_GET['inicio'];
        $iFim       = $_GET['fim'];
        declararCidades($iInicio, $iFim, $iVertices);
        
        declararInicioCaminhos($aCaminho);
        executamosOsCara($aDist, $aCaminho, $iVertices, $iInf);
        declararFimCaminhos($aCaminho);
        
        imprimirMatriz($aDist, $aCaminho, $iInf, $iInicio, $iFim); 
    ?>
</body>
</html>