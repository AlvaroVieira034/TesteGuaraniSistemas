create database bdtestedguarani

-- Criar o banco de dados
CREATE DATABASE bdtestedguarani;
GO

USE bdtestedguarani;
GO

-- Iniciar transação
BEGIN TRANSACTION;

-- Criar tabela de produtos
CREATE TABLE tab_produto (
   cod_produto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   des_descricao VARCHAR(100) UNIQUE,
   des_marca VARCHAR(50),
   val_preco FLOAT
);
GO

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
GO

SELECT * FROM tab_produto

-- Criar tabela de clientes
CREATE TABLE tab_cliente (
   cod_cliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
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
GO

--- Trigger para verificar se telefone do cliente foi inserido
CREATE TRIGGER trg_VerificaTelefone
ON tab_cliente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE des_telefone IS NULL OR LTRIM(RTRIM(des_telefone)) = ''
    )
    BEGIN
        RAISERROR('Erro: O telefone do cliente é obrigatório.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

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


GO

-- Criar tabela de pedidos
CREATE TABLE tab_pedido (
   cod_pedido INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   dta_pedido DATE,
   cod_cliente INT NOT NULL,
   val_pedido FLOAT,
   FOREIGN KEY (cod_cliente) REFERENCES tab_cliente (cod_cliente)
);
GO

-- Inserir dados na tabela de pedidos
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-01-01', 1, 760);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-01-01', 2, 44);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-07', 4, 320);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-09', 2, 1797);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-10', 7, 1883);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-10', 5, 1258);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-12', 1, 4722);
INSERT INTO tab_pedido (dta_pedido, cod_cliente, val_pedido) VALUES ('2024-09-22', 1, 2445);
GO

delete from tab_pedido
DBCC CHECKIDENT (tab_pedido, RESEED, 0);
select * from tab_pedido

-- Criar tabela de itens do pedido
CREATE TABLE tab_pedido_item (
   id_pedido INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   cod_pedido INT NOT NULL,
   cod_produto INT NOT NULL,
   val_quantidade INT NOT NULL,
   val_precounitario FLOAT,
   val_totalitem FLOAT,
   FOREIGN KEY (cod_pedido) REFERENCES tab_pedido (cod_pedido),
   FOREIGN KEY (cod_produto) REFERENCES tab_produto (cod_produto)
);
GO



CREATE PROCEDURE sp_Top2_ProdutosMaisVendidos
    @DataInicio DATE,
    @DataFim DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 2
        p.cod_produto,
        pr.des_descricao,
        pr.des_marca,
        SUM(p.val_quantidade) AS QuantidadeVendida,
        SUM(p.val_totalitem) AS ValorTotalVendido
    FROM tab_pedido_item p
    INNER JOIN tab_pedido ped ON p.cod_pedido = ped.cod_pedido
    INNER JOIN tab_produto pr ON p.cod_produto = pr.cod_produto
    WHERE (@DataInicio IS NULL OR ped.dta_pedido >= @DataInicio)
      AND (@DataFim IS NULL OR ped.dta_pedido <= @DataFim)
    GROUP BY p.cod_produto, pr.des_descricao, pr.des_marca
    ORDER BY QuantidadeVendida DESC;
END;
GO

select * from tab_pedido_item
select * from tab_produto


-- Inserir dados na tabela de itens da pedido
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

GO

-- Confirmar a transação
COMMIT TRANSACTION;
GO
