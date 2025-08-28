-- Criar o banco de dados
--CREATE DATABASE 'bdtestedguarani.fdb'
--USER 'SYSDBA' PASSWORD 'masterkey'
--DEFAULT CHARACTER SET UTF8;

-- Criar tabela de produtos
CREATE TABLE tab_produto (
   cod_produto INT NOT NULL PRIMARY KEY,
   des_descricao VARCHAR(100) UNIQUE,
   des_marca VARCHAR(50),
   val_preco FLOAT
);

-- Criar generator e trigger para cod_produto
CREATE SEQUENCE gen_tab_produto;

CREATE TRIGGER trg_tab_produto_pk FOR tab_produto
BEFORE INSERT
AS
BEGIN
   IF (NEW.cod_produto IS NULL) THEN
      NEW.cod_produto = NEXT VALUE FOR gen_tab_produto;
END;

-- Inserir dados na tabela de produtos
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('HD EXTERNO 1TB', 'SEAGATE', 760);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('PEN DRIVE 16 GB', 'SANDISK', 22);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('PLACA DE VIDEO', 'GEFORCE', 865);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('KIT TECLADO E MOUSE', 'DELL', 128);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('MOUSE PAD EM COURO', 'COUROTECH', 45);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('ROTEADOR',  'HUAWEI', 268);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('PLACA MAE INTEL I7 12a GERAÇÃO', 'INTEL', 1580);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('NOTEBOOK GAMER', 'DELL', 12760);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('MONITOR 24 POL', 'SAMSUNG', 1138);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('MOUSE SEM FIO', 'LOGITECH', 85);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('TECLADO SEM FIO', 'LOGITECH', 90);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('IMPRESSORA LASER', 'HP', 1465);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('TONER IMPRESSORA', 'HP', 418);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('MONITOR 22 POL', 'LG', 962);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('HD SSD 1 TB', 'SEAGATE', 825);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('NOTEBOOK I5 8GB SSD 1TB', 'DELL', 3760);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('CADEIRA GAMER', 'DXRACER', 1760);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('PLACA MAE', 'ASUS', 1250);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('GABINETE GAMER', 'EASYTEC', 657);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('KIT TECLADO/MOUSE/HEADSET GAMER', 'LOGITECH', 760);
INSERT INTO tab_produto (des_descricao, des_marca, val_preco) VALUES ('HEADSET', 'LOGITECH', 160);



-- Criar tabela de clientes
CREATE TABLE tab_cliente (
   cod_cliente INT NOT NULL PRIMARY KEY,
   des_razaosocial VARCHAR(100),
   des_nomefantasia VARCHAR(50),
   des_cep VARCHAR(10),
   des_endereco VARCHAR(100),
   des_complemento VARCHAR(50),
   des_cidade VARCHAR(100),
   des_uf VARCHAR(2),
   des_cnpj VARCHAR(20),
   des_telefone VARCHAR(20)
);

-- Generator e trigger de auto incremento
CREATE SEQUENCE gen_tab_cliente;

CREATE TRIGGER trg_tab_cliente_pk FOR tab_cliente
BEFORE INSERT
AS
BEGIN
   IF (NEW.cod_cliente IS NULL) THEN
      NEW.cod_cliente = NEXT VALUE FOR gen_tab_cliente;
END;

-- Trigger para validar telefone
CREATE TRIGGER trg_VerificaTelefone FOR tab_cliente
BEFORE INSERT
AS
BEGIN
   IF (NEW.des_telefone IS NULL OR TRIM(NEW.des_telefone) = '') THEN
      EXCEPTION ex_telefone_obrigatorio;
END;

-- Criar exceção
CREATE EXCEPTION ex_telefone_obrigatorio 'Erro: O telefone do cliente é obrigatório.';

-- Inserir dados na tabela de clientes
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('AMV INFORMATICA LTDA', 'AMV INFO', '30130-040', 'RUA ANTONIO DE ALBUQUERQUE, 377', 'SALA 06', 'BELO HORIZONTE', 'MG', '642389590001-42', '31 3286-0107');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('MADEIRART LTDA', 'MADEIRART', '30320-050', 'RUA PARAIBA 1317', 'SALA 204', 'BELO HORIZONTE', 'MG', '174019930001-42', '31 3364-2050');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('CONSTRUTORA WR LTDA', 'CONSTRUTORA WR', '30320-050', 'RUA PARAIBA 1317', 'SALA 206', 'BELO HORIZONTE', 'MG', '355148570001-10', '31 3375-2115');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('COMERCIAL AV LTDA', 'COMERCIAL AV', '30315-600', 'RUA GRAO MOGOL 317', '', 'BELO HORIZONTE', 'MG', '211508750001-42', '31 3225-4010');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('VIACAO SANTANA LTDA', 'VIACAO SANTANA', '30150-030', 'AV GETULIO VARGAS, 200', 'SALA 605', 'BELO HORIZONTE', 'MG', '652280300001-50', '31 3228-4110');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('AAE EMBALAGENS LTDA', 'AA EMBALAGENS', '30150-030', 'RUA PERNAMBUCO 300', 'SALA 201', 'BELO HORIZONTE', 'MG', '111111110001/75', '31 3226-3010');
INSERT INTO tab_cliente (des_razaosocial, des_nomefantasia, des_cep, des_endereco, des_complemento, des_cidade, des_uf, des_cnpj, des_telefone ) 
       VALUES ('BAR DO TIAO LTDA', 'BUTECO DO TIAO', '30150-030', 'RUA PERNAMBUCO 300', 'SALA 201', 'BELO HORIZONTE', 'MG', '111111110001/75', '31 3226-3010');

-- Criar tabela de pedidos
CREATE TABLE tab_pedido (
   cod_pedido INT NOT NULL PRIMARY KEY,
   dta_pedido DATE,
   cod_cliente INT NOT NULL,
   val_pedido FLOAT,
   FOREIGN KEY (cod_cliente) REFERENCES tab_cliente (cod_cliente)
);

-- Generator e trigger
CREATE SEQUENCE gen_tab_pedido;


CREATE TRIGGER trg_tab_pedido_pk FOR tab_pedido
BEFORE INSERT
AS
BEGIN
   IF (NEW.cod_pedido IS NULL) THEN
      NEW.cod_pedido = NEXT VALUE FOR gen_tab_pedido;
END;


-- Inserir dados
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-01-01', 1, 760);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-01-01', 2, 44);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-07', 4, 320);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-09', 2, 1797);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-10', 7, 1883);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-10', 5, 1258);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-12', 1, 4722);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-22', 1, 2445);

-- Criar tabela de itens do pedido
CREATE TABLE tab_pedido_item (
   id_pedido INT NOT NULL PRIMARY KEY,
   cod_pedido INT NOT NULL,
   cod_produto INT NOT NULL,
   val_quantidade INT NOT NULL,
   val_precounitario FLOAT,
   val_totalitem FLOAT,
   FOREIGN KEY (cod_pedido) REFERENCES tab_pedido (cod_pedido),
   FOREIGN KEY (cod_produto) REFERENCES tab_produto (cod_produto)
);

-- Generator e trigger
CREATE SEQUENCE gen_tab_pedido_item;

CREATE TRIGGER trg_tab_pedido_item_pk FOR tab_pedido_item
BEFORE INSERT
AS
BEGIN
   IF (NEW.id_pedido IS NULL) THEN
      NEW.id_pedido = NEXT VALUE FOR gen_tab_pedido_item;
END;


-- Inserir dados
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (1, 1, 1, 760, 760);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (2, 2, 2, 22, 44);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (3, 11, 1, 85, 85);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (4, 16, 1, 3760, 3760);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (5, 21, 2, 160, 320);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (6, 1, 1, 760, 760);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (6, 2, 2, 44, 44);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (6, 3, 1, 865, 865);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (6, 4, 1, 128, 128);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (7, 18, 1, 1250, 1250);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (8, 12, 1, 1465, 1465);
INSERT INTO tab_pedido_item (cod_pedido, cod_produto, val_quantidade, val_precounitario, val_totalitem) VALUES (8, 13, 1, 418, 418);

-- Procedure para top 2 produtos mais vendidos
CREATE PROCEDURE sp_ProdutosMaisVendidos (
    DataInicio DATE,
    DataFim DATE,
    MostrarTodos INT  -- 1 = todos, 0 = top 2
)
RETURNS (
    cod_produto INT,
    des_descricao VARCHAR(100),
    des_marca VARCHAR(50),
    QuantidadeVendida INT,
    ValorTotalVendido FLOAT
)
AS
BEGIN
    IF (MostrarTodos = 1) THEN
    BEGIN
        FOR
            SELECT
                p.cod_produto,
                pr.des_descricao,
                pr.des_marca,
                SUM(p.val_quantidade),
                SUM(p.val_totalitem)
            FROM tab_pedido_item p
            JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido
            JOIN tab_produto pr ON p.cod_produto = pr.cod_produto
            WHERE (:DataInicio IS NULL OR ped.dta_pedido >= :DataInicio)
              AND (:DataFim IS NULL OR ped.dta_pedido <= :DataFim)
            GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca
            ORDER BY SUM(p.val_quantidade) DESC
            INTO :cod_produto, :des_descricao, :des_marca, :QuantidadeVendida, :ValorTotalVendido
        DO
            SUSPEND;
    END
    ELSE
    BEGIN
        FOR
            SELECT
                p.cod_produto,
                pr.des_descricao,
                pr.des_marca,
                SUM(p.val_quantidade),
                SUM(p.val_totalitem)
            FROM tab_pedido_item p
            JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido
            JOIN tab_produto pr ON p.cod_produto = pr.cod_produto
            WHERE (:DataInicio IS NULL OR ped.dta_pedido >= :DataInicio)
              AND (:DataFim IS NULL OR ped.dta_pedido <= :DataFim)
            GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca
            ORDER BY SUM(p.val_quantidade) DESC
            ROWS 2
            INTO :cod_produto, :des_descricao, :des_marca, :QuantidadeVendida, :ValorTotalVendido
        DO
            SUSPEND;
    END
END;