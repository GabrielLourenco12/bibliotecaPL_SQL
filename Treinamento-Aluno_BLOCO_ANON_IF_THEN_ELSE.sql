/*CRIANDO UM BLOCO AN�NIMO*/
SET  SERVEROUTPUT ON
DECLARE

    vsalario number;
    vpercaumento number;
    vtotalsal number;
    
BEGIN

    vsalario:=2500.00;
    vpercaumento:=30/100;
    vtotalsal:= vsalario + (vsalario*vpercaumento);
    DBMS_OUTPUT.PUT_line ('O novo sal�rio � de: '||vtotalsal);
    
END;


SET  SERVEROUTPUT ON
DECLARE    
    vsalario number :=4500;
    vsituacao boolean;
    vpercaumento number :=30/100;
    vtotalsal number;

BEGIN
    vsituacao := FALSE;
    
    IF vsituacao THEN
        vtotalsal := vsalario + (vsalario*vpercaumento);
        DBMS_OUTPUT.PUT_LINE('O novo sal�rio � de: '||vtotalsal);
    ELSE
        DBMS_OUTPUT.PUT_LINE('N�o houve aumento!!! '||vtotalsal);
    END IF;
END;



/*Manipulando vari�veis data e string*/
SET SERVEROUTPUT ON
DECLARE

    vdata_pagamento date:= '02/01/2011';
    
BEGIN
    DBMS_OUTPUT.PUT_line (' A data do pagamento � : '||vdata_pagamento);
    -- Acrescenta 10 dias a data de pagamento
    vdata_pagamento:=vdata_pagamento+10;
    DBMS_OUTPUT.PUT_line (' A data do pagamento mais 10 dias � de : '
    ||vdata_pagamento);
    -- Data do sistema
    DBMS_OUTPUT.PUT_line (' A data do sistema �: '||sysdate);
    -- Data entre o pagamento e do sistema
    DBMS_OUTPUT.PUT_LINE (' A quantidade de dias entre hoje e o pagamento: '
    ||(sysdate - vdata_pagamento));
    -- data entre o pagamento e do sistema ajustado
    DBMS_OUTPUT.PUT_line (' A quantidade de dias entre hoje e'||
    ' o pagamento-ajustado :'||floor(sysdate - vdata_pagamento));
END;
    
    
  
--Utilizando identificadores de blocos an�nimos

SET SERVEROUTPUT ON
    <<EXTERNO>>
DECLARE
    vsalario number :=4500;
    vsituacao boolean;
    vpercaumento number :=30/100;
    vtotalsal number;
BEGIN
    vsituacao:=TRUE;
    IF vsituacao THEN
        vtotalsal := vsalario + (vsalario*vpercaumento);
        DBMS_OUTPUT.PUT_line (' O novo sal�rio � de: '||vtotalsal);
    ELSE
        DBMS_OUTPUT.PUT_line (' N�o houve aumento!!! '||vtotalsal);
    END IF;
    <<INTERNO>>
    DECLARE
    Vtotalsal NUMBER :=5000;
    BEGIN
        DBMS_OUTPUT.PUT_line (' O sal�rio externo � de : '||externo.vtotalsal);
        DBMS_OUTPUT.PUT_line (' O sal�rio local � de : '||vtotalsal);
    END;
END;
    
    
    
/*Utilizando comando condicional (IF THEN e ELSE )*/
SET SERVEROUTPUT ON
DECLARE
    vsalario number :=3500;
    vsituacao boolean;
    vpercaumento number :=30/100;
    vtotalsal number;
BEGIN
    vsituacao:=FALSE;
    
    IF vsituacao THEN
        vtotalsal := vsalario + (vsalario*vpercaumento);
        DBMS_OUTPUT.PUT_line (' O novo sal�rio com a situacao TRUE �: '
        ||vtotalsal);
    ELSE
        IF vsalario>4000 THEN
            vtotalsal:=vsalario;
        ELSE
            vtotalsal:=vsalario-1000;
        END IF;
        DBMS_OUTPUT.PUT_line (' O novo sal�rio com a situacao FALSE �: '
        ||vtotalsal);
    END IF;
END;
    
    
    
    
    
    
    
    
    


