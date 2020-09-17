--sequencia de codigo que � executada quando h� ocorr�ncia de um determinado 
--evento no banco de dados
--Funciona muito para auditoria (quem fez isso?) e validacao de dados
--Gatilhos before e after

--Criando uma trigger(gatilho) N�o permite o cadastramento de autores menores que 16 anos
CREATE OR REPLACE TRIGGER TR_MENOR
BEFORE INSERT OR UPDATE
--GATILHO ANTES
ON TB_AUTOR
FOR EACH ROW

DECLARE vidade NUMBER;
BEGIN
    vidade:=EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM :NEW.data_nascimento);
    
    IF (vidade=16) AND (EXTRACT (MONTH FROM SYSDATE) >
    EXTRACT(MONTH FROM :NEW.data_nascimento)) THEN
        vidade:=vidade-1;
    END IF;
    IF (vidade<16) THEN
        RAISE_APPLICATION_ERROR(-20301,'Autor menor do que 16 anos');
    END IF;
END;

INSERT INTO TB_AUTOR VALUES (sq_autor.nextval,'Fernando','M','23.10.2010');
INSERT INTO TB_AUTOR VALUES (sq_autor.nextval,'Fernando','M','23.10.2000');




--Os produtos s�o somados e n�o podem ultrapassar 600 reais.
CREATE OR REPLACE TRIGGER TR_LIMITE_PEDIDO
BEFORE INSERT OR UPDATE
ON TB_ITENS_PEDIDO
FOR EACH ROW

DECLARE vvalor_pedido number;
BEGIN
    SELECT
        SUM(preco)
    INTO
        vvalor_pedido
    FROM
        tb_itens_pedido
    WHERE
        id_pedido=:New.id_pedido;
        --:NEW se refere ao novo comando insert
    vvalor_pedido:=vvalor_pedido+:New.preco;
    IF(vvalor_pedido > 600) THEN
        RAISE_APPLICATION_ERROR (-20301,'Valor limite do pedido excedido!!!');
    END IF;
END;

INSERT INTO TB_ITENS_PEDIDO VALUES(sq_itens_pedido.nextval,1,1,10,350);





--� dado baixa no estoque ao acrescentar um novo livro ao pedido
CREATE OR REPLACE TRIGGER TR_BAIXA_ESTOQUE
AFTER INSERT OR UPDATE
--TRIGGER DEPOIS
ON TB_ITENS_PEDIDO
FOR EACH ROW

BEGIN
UPDATE
    TB_LIVRO
SET
    QTDE_ESTOQUE=QTDE_ESTOQUE-:NEW.quantidade
WHERE
    id_livro=:NEW.id_livro;
END;

INSERT INTO TB_ITENS_PEDIDO VALUES(sq_itens_pedido.nextval,1,1,10,50); 




--N�o permite um reajuste de mais de 50%
CREATE OR REPLACE TRIGGER TR_LIMITE_REAJUSTE
BEFORE UPDATE
--ANTES DA A��O
ON TB_LIVRO
FOR EACH ROW

    BEGIN
        IF (:NEW.preco >= :OLD.preco*1.5) THEN
            --OLD COMPARA O PRECO ANTIGO ANTES DO UPDATE
            RAISE_APPLICATION_ERROR (-20334,'Reajuste n�o permitido!!');
        END IF;
    END;

UPDATE TB_LIVRO SET PRECO=20 WHERE id_livro=1;





--Registrando na tabela TB_LOG a elimina��o do registro da editora que deseja, 
--informando o usu�rio e data do sistema

CREATE OR REPLACE TRIGGER TB_LOG_EDITORA
AFTER DELETE
--depois de deletar alguma coisa vai registrar quem fez
ON TB_EDITORA
FOR EACH ROW
DECLARE voperacao varchar2(100);

    BEGIN
        voperacao:='DELECAO DA EDITORA : '||:OLD.descricao;
        INSERT INTO TB_LOG VALUES (sq_log.nextval, user,sysdate,voperacao);
    END;
    
INSERT INTO TB_EDITORA VALUES (sq_EDITORA.nextval, 'Bet�nia','Rua Azul');
DELETE FROM TB_EDITORA WHERE UPPER(descricao)='BET�NIA'












