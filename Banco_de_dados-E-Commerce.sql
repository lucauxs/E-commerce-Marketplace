-- Trabalho: E-commerce marketplace (segunda opção)

-- *******************
-- 3- CRIANDO TABELAS:
-- *******************

-- Criando tabela usuarios:
CREATE TABLE usuarios(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    nome_usuario VARCHAR(50) UNIQUE NOT NULL, 
	email VARCHAR(100) UNIQUE NOT NULL, 
    cpf VARCHAR(15) UNIQUE NOT NULL, 
	cnpj VARCHAR(20) UNIQUE DEFAULT NULL,
    data_nascimento DATE NOT NULL
);

-- Criando tabela pedidos:
CREATE TABLE pedidos(
    id SERIAL PRIMARY KEY,
    data_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
	id_usuario INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE
);

-- -- Criando tabela endereços:
CREATE TABLE enderecos(
    id SERIAL PRIMARY KEY,
    cep VARCHAR(10) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    complemento VARCHAR(100),
    id_usuario INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Criando tabela categorias:
CREATE TABLE categorias(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT
);

-- Criando tabela produtos:
CREATE TABLE produtos(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    data_de_fabricacao DATE NOT NULL,
    valor_unitario DECIMAL NOT NULL,
    id_usuario INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    id_categoria INTEGER NOT NULL REFERENCES categorias(id)
);

-- Criando tabela itens_do_pedido:
CREATE TABLE itens_do_pedido(
    id_pedido INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    id_produto INTEGER NOT NULL REFERENCES produtos(id) ON DELETE CASCADE,
	quantidade_produto INTEGER NOT NULL,
	PRIMARY KEY (id_pedido, id_produto)
);

-- Criando tabela telefones: 
CREATE TABLE telefones(
	id SERIAL PRIMARY KEY,
	telefone VARCHAR(25),
	id_usuario INTEGER NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Criando tabela estoque:
CREATE TABLE estoque(
    id SERIAL PRIMARY KEY,
    quantidade INTEGER,
    id_produto INTEGER NOT NULL REFERENCES produtos(id) ON DELETE CASCADE 
);



-- *******************************
-- 4- INSERINDO DADOS NAS TABELAS:
-- *******************************

-- Inserindo dados em USUÁRIOS:
INSERT INTO usuarios (nome, nome_usuario, email, cpf, cnpj, data_nascimento) VALUES
	('Alice Silva', 'alice123', 'alice@email.com', '123.456.789-01', '365.869.038\0001.29', '1990-05-15'),
    ('Bob Santos', 'bob88', 'bob@email.com', '987.654.321-09', '022.868.934\0001-33', '1985-12-10'),
    ('Carol Lima', 'carol22', 'carol@email.com', '555.555.555-55', '890.057.149\0001-22', '1998-03-20'),
    ('David Oliveira', 'david77', 'david@email.com', '111.222.333-44', '789.393.695\0001-54', '2000-09-05'),
    ('Eva Pereira', 'eva99', 'eva@email.com', '444.444.444-44', '294.693.249\0001-92', '1995-07-18'),
    ('Niltom Cobain', 'niltCobain27', 'cobain@email.com', '272.727.272-72', '890.656.797\0001-65', '1994-02-18'),
    ('Elliot Anderson', 'elliot0101', 'fsociety@email.com', '010.101.010-10', '199.646.890\0001-89', '1990-04-08'),
    ('Bruno Gallagher', 'gallagher29', 'gallagher@email.com', '889.775.344-42','989.775.288\0001-54', '1971-08-19'),
    ('Frida Bouvier', 'frida96', 'fridabou@email.com', '467.384.293-50', NULL, '1979-01-28'),
    ('Xavier Wilson', 'wilson03', 'xavirwil@email.com', '382.485.228-29', NULL, '1999-11-02');

-- Inserindo dados em ENDEREÇOS:
INSERT INTO enderecos (cep, uf, cidade, bairro, logradouro, complemento, id_usuario) VALUES
    ('12345-678', 'RJ', 'Teresópolis', 'Centro', 'Rua Principal n10', 'Apto 101', 1),
    ('54321-987', 'RJ', 'Petrópolis', 'Laranjeiras', 'Av. das Flores n550', NULL, 2),
    ('98765-432', 'RJ', 'Nova Friburgo', 'Centro', 'Rua das Montanhas n200', 'Casa 2', 3),
    ('11111-222', 'SP', 'Jundiaí', 'Vila Lacerda', 'Rua Vinhedo n10', NULL, 4),
    ('99999-000', 'RJ', 'Teresópolis', 'Alto', 'Rua da Serra n1350', 'Bloco B', 5),
    ('89992-239', 'MG', 'Ouro Preto', 'Bandeira', 'Rua Governador n711', 'Casa 6', 6),
    ('23930-323', 'RJ', 'Itaocara', 'Das Agulhas', 'Av. Bezouro n92', NULL, 7),
    ('32832-322', 'MS', 'Dourados', 'Cerâmica', 'Rua tabajira n92', 'Casa 21', 8),
    ('93932-989', 'MT', 'Cuiabá', 'Esperança', 'Rua Schuller n32', 'Apto 78', 9),
    ('59694-923', 'MS', 'Três Lagoas', 'Frinape', 'Av. Rio Azul n21', 'Casa 62', 10);

-- Inserindo dados em CATEGORIAS:
INSERT INTO categorias (nome, descricao) VALUES
	('Eletrônicos', 'Gadgets e dispositivos eletrônicos'),
	('Moda', 'Roupas, calçados e acessórios'),
	('Alimentos', 'Produtos alimentícios'),
	('Decoração', 'Itens para casa e decoração'),
	('Esportes', 'Equipamentos esportivos');

-- Inserindo dados em PRODUTOS:
INSERT INTO produtos (nome, descricao, data_de_fabricacao, valor_unitario, id_usuario, id_categoria) VALUES
    ('Smartphone X1', 'Smartphone com ótimas qualidades avançadas', '2024-08-01', 899.99, 1, 1),
    ('Tênis Esportivo', 'Tênis de corrida para atividades ao ar livre', '2024-07-15', 129.99, 2, 2),
    ('Camiseta Estampada', 'Camiseta de algodão com estampa de gatinho', '2024-08-10', 29.99, 3, 3),
    ('Chocolate Amargo', 'Barra de chocolate 70% cacau', '2024-08-05', 4.99, 4, 4),
    ('Luminária de Mesa', 'Luminária de mesa LED moderna', '2024-08-18', 49.99, 5, 5),
    ('Playstation 5 Slim', 'Melhor vídeo-game da última geração', '2024-08-18', 3700.00, 2, 1),
    ('Camisa do Flamengo', 'Camisa oficial do time do flamengo', '2024-08-18', 449.99, 3, 5),
    ('Bola de futebol', 'Bola de futebol profissional', '2024-08-18', 249.99, 4, 5),
    ('Relógio Garmin', 'Relógio para corredores, com GPS', '2024-03-10', 1250.00, 6, 5),
    ('PSP Slim', 'Vídeo-game portátil', '2016-06-28', 1600.00, 5, 1),
    ('Quadro retrô', 'Quadro decorativo', '2014-08-13', 2100.00, 9, 4),
    ('Botas de couro', 'Botas de couro nos seg. tamanhos: 34-43', '2019-07-25', 350.99, 8, 2),
    ('Chiclete colorido', 'Chiclete de caixinha contendo 30 unidades', '2024-08-10', 6.99, 4, 3),
    ('Escultura Elephant', 'Escultura decoratva de resina', '2019-09-30', 450.00, 7, 4),
    ('Chuteira master class', 'Chuteira de trava profissional nos seg. tamanhos: 32-43', '2020-12-03', 299.99, 7, 5);

-- Inserindo dados em ESTOQUE:
INSERT INTO estoque (quantidade, id_produto) VALUES
    (10, 1),
    (5, 2),
    (8, 3),
    (24, 4),
    (16, 5),
    (2, 6),
    (3, 7),
    (null, 8),
    (16, 9),
    (8, 10),
    (4, 11),
    (15, 12),
    (70, 13),
    (9, 14),
    (26, 15);

-- Inserindo dados em PEDIDOS:
INSERT INTO pedidos(data_pedido, id_usuario) VALUES
    ('2024-08-26', 3),
    ('2024-08-29', 4),
    ('2024-08-21', 5),
    ('2024-08-27', 9),
    ('2024-09-04', 4),
    ('2024-09-20', 2),
    ('2024-09-02', 8),
    ('2024-09-08', 6),
    ('2024-10-04', 1),
    ('2024-10-16', 3),
    ('2024-11-19', 8),
    ('2024-11-26', 9),
    ('2024-11-13', 7),
    ('2024-10-21', 8),
    ('2024-10-23', 5),
    ('2024-10-06', 3),
    ('2024-12-20', 9),
    ('2024-12-02', 10);

-- Inserindo dados em INTES_DO_PEDIDO:
INSERT INTO itens_do_pedido (id_pedido, id_produto, quantidade_produto) VALUES
	(1, 1, 2), 
    (2, 2, 1), 
    (3, 3, 4), 
    (5, 11, 10), 
    (18, 5, 2), 
    (15, 6, 1), 
    (14, 15, 2), 
    (13, 11, 2), 
    (12, 13, 11),
    (11, 9, 3),
    (10, 11, 2), 
    (9, 10, 1), 
    (1, 9, 1), 
    (1, 8, 2), 
    (6, 7, 4),
	(4, 5, 1),
	(7, 3, 2),
	(8, 10, 1); 
	
-- Inserindo dados em TELEFONES:
INSERT INTO telefones(telefone, id_usuario) VALUES
    ('+55(21)99478-6867', 1),
    ('+55(22)2742-8854', 2),
    ('+55(71)9174-0943', 3),
    ('+55(11)99421-6677', 4),
    ('+55(24)96589-2233', 5),
    ('+55(11)95622-9845', 6),
    ('+55(22)93448-9832', 7),
    ('+55(22)99992-2803', 8),
    ('+55(11)93650-0003', 9),
    ('+55(21)99321-0954', 10),
	('+55(22)96746-2128', 1);



-- ******************************
-- REQUISITOS TRABALHO DO 5 AO 7:
-- ******************************

-- *** 5- ATUALIZAÇÃO DE REGISTROS ***:
UPDATE produtos SET nome = 'Playstation 5 Slim Disk' WHERE id = 6; -- Atualiza nome do produto no id de um produto específico.
SELECT * FROM produtos

UPDATE estoque SET quantidade = 5 WHERE id_produto = 8; -- Atualiza a quantidade de estoque de um id de produto específico. 

UPDATE produtos SET nome = 'Camisa do Barcelona' WHERE id = 7; -- Atualiza nome do produto no id de um produto específico.

UPDATE itens_do_pedido SET quantidade_produto = 2 WHERE id_pedido = 1 AND id_produto = 1; -- Atualiza a quantidade de produto no itens_produto (tabela chave composta), função criada caso encontre algum erro antes da postagem do produto, por exemplo. 

UPDATE categorias SET nome = 'Alimentos industrializados', descricao = 'Produtos com técnicas de adição de ingredientes e produtos químicos' WHERE id = 3; -- Função criada para adicionar uma subcategoria em Alimentos.

-- *** 6- EXCLUSÃO DE UM REGISTRO ***: 
-- Deleta um pedido pelo id do pedido:
DELETE FROM itens_do_pedido WHERE id_pedido = 3; 
SELECT * FROM itens_do_pedido

-- Deleta um usuário pelo id:
DELETE FROM usuarios WHERE id = 10;

-- Deleta um produto pelo id:
DELETE FROM produtos WHERE id = 8;


-- *** 7.1- FAÇA DUAS CONSULTAS COM ALGUM TIPO DE JUNÇÃO ***: 
-- selecionar o nome, nome do usuário e o produto comprado + valor unitário + descrição do produto que ele comprou, ordenado por ordem crescente do valor unitário
SELECT u.nome AS usuario, p.nome AS produto, p.valor_unitario, p.descricao FROM usuarios u
JOIN produtos p ON p.id_usuario = u.id
ORDER BY p.valor_unitario;

-- Seleciona o nome do usuário, sua uf, sua cidade e seus telefones:
SELECT u.nome AS usuario, e.uf, e.cidade, STRING_AGG(t.telefone, ', ') AS telefones
FROM usuarios u
JOIN enderecos e ON e.id_usuario = u.id
JOIN telefones t ON t.id_usuario = u.id
GROUP BY u.nome, e.uf, e.cidade
ORDER BY u.nome;

-- Seleciona o nome das categorias e seus respectivos produtos por ordem alfabetica 
SELECT c.nome AS categoria, string_agg(p.nome, ' | ') AS nome_produtos
FROM categorias c
JOIN produtos p ON p.id_categoria = c.id
GROUP BY c.nome
ORDER BY c.nome;

--Seleciona o nome e as informações númericas de cada usuário:
SELECT u.nome, u.cpf, u.cnpj, STRING_AGG(t.telefone, ' | ') AS telefones, e.cep FROM telefones t
INNER JOIN usuarios u ON u.id = t.id_usuario
INNER JOIN enderecos e ON e.id_usuario = u.id
GROUP BY u.nome, u.cpf, u.cnpj, e.cep
ORDER BY u.nome;

-- Seleciona os produtos, descrições, seus respectivos preços e a quantidade em estoque:
SELECT pr.nome AS produto, pr.descricao AS descrição, pr.valor_unitario AS valor_unitário, es.quantidade AS estoque
FROM estoque es
JOIN produtos pr ON es.id_produto = pr.id
ORDER BY valor_unitario DESC, Estoque DESC;


-- *** 7.2- FAÇA UM COMANDO SQL COM COUNT() E GROUP BY ***: 
-- Seleciona o nome da categoria e quantos produtos tem nela ordenado de forma decrescente pela quantidade:
SELECT c.nome AS categoria, COUNT(p.id_categoria) AS quantidade_produtos
FROM categorias c
JOIN produtos p ON p.id_categoria = c.id
GROUP BY c.nome
ORDER BY quantidade_produtos DESC;

-- Exibe nome do usuário, seu produto e a quantidade do produto
SELECT u.nome AS usuario, pr.nome AS produto, COUNT (ip.quantidade_produto) AS quantidade_produtos
FROM usuarios u
JOIN produtos pr ON pr.id_usuario = u.id
JOIN itens_do_pedido ip ON ip.id_produto = pr.id
GROUP BY u.nome, ip.quantidade_produto, pr.nome
ORDER BY ip.quantidade_produto;


-- *** 7.3- SQL PARA A CONSTRUÇÃO DE NOTA FICAL ***: 
CREATE VIEW nota_fiscal AS
SELECT 
	-- COLUNAS DO PEDIDO:
	i.id_pedido AS num_pedido,
	pe.data_pedido,
	-- COLUNAS DO VENDEDOR:
	u_vendedor.nome AS vendedor,
	u_vendedor.cnpj AS cnpj_vendedor,
	string_agg(te_vendedor.telefone, '  ;  ') AS telefone_vendedor,
	en_vendedor.cep AS cep_vendedor,
	en_vendedor.uf AS uf_vendedor,
	en_vendedor.cidade AS cidade_vendedor,
	en_vendedor.bairro AS bairro_vendedor,
	en_vendedor.logradouro AS logradouro_vendedor,
	en_vendedor.complemento AS complemento_vendedor,
	-- COLUNAS DO COMPRADOR:
	u_comprador.nome AS comprador,
	u_comprador.cpf AS cpf_comprador,
	string_agg(te_comprador.telefone, '  ;  ') AS telefone_comprador, 
	u_comprador.email AS email_comprador,
	en_comprador.cep AS cep_comprador,
	en_comprador.uf AS uf_comprador,
	en_comprador.cidade AS cidade_comprador,
	en_comprador.bairro AS bairro_comprador,
	en_comprador.logradouro AS logradouro_comprador,
	en_comprador.complemento AS complemento_comprador,
	-- COLUNAS DO PRODUTO:
	pr.nome AS produto, 
	pr.valor_unitario, 
	i.quantidade_produto, 
	pr.valor_unitario * i.quantidade_produto AS valor_total_qnt_produto,
	SUM(pr.valor_unitario * i.quantidade_produto) OVER (PARTITION BY i.id_pedido) AS valor_total_pedido
FROM usuarios AS u_comprador
JOIN pedidos AS pe ON u_comprador.id = pe.id_usuario
JOIN telefones AS te_comprador ON u_comprador.id = te_comprador.id_usuario
JOIN itens_do_pedido AS i ON pe.id = i.id_pedido
JOIN produtos AS pr ON i.id_produto = pr.id
JOIN usuarios AS u_vendedor ON pr.id_usuario = u_vendedor.id
JOIN enderecos AS en_vendedor ON u_vendedor.id = en_vendedor.id_usuario
JOIN telefones AS te_vendedor ON u_vendedor.id = te_vendedor.id_usuario
JOIN enderecos AS en_comprador ON u_comprador.id = en_comprador.id_usuario
GROUP BY i.id_pedido, pe.data_pedido, u_vendedor.nome, u_vendedor.cnpj, en_vendedor.cep, en_vendedor.uf, en_vendedor.cidade, en_vendedor.bairro, en_vendedor.logradouro, en_vendedor.complemento, u_comprador.nome, u_comprador.cpf, u_comprador.email, en_comprador.cep, en_comprador.uf, en_comprador.cidade, en_comprador.bairro, en_comprador.logradouro, en_comprador.complemento, pr.nome, pr.valor_unitario, i.quantidade_produto; 

SELECT * FROM nota_fiscal
WHERE num_pedido = 1;


-- *************************
-- CRIANDO TRIGGER E FUNÇÃO:
-- *************************

-- Função:
CREATE OR REPLACE FUNCTION verifica_estoque() RETURNS TRIGGER AS $$
DECLARE
    estoque_atual INT;
BEGIN
    SELECT quantidade INTO estoque_atual FROM estoque WHERE id_produto = NEW.id_produto;
    IF NEW.quantidade_produto > estoque_atual OR estoque_atual IS NULL OR NEW.quantidade_produto = 0 THEN
        RAISE EXCEPTION 'Quantidade insuficiente em estoque';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger:
CREATE TRIGGER tr_verifica_estoque
BEFORE INSERT OR UPDATE ON itens_do_pedido
FOR EACH ROW
EXECUTE FUNCTION verifica_estoque();



-- **************
-- DROP E SELECT:
-- **************

-- Para visualização das tabelas montadas e suas respectivas colunas:
SELECT * FROM estoque;
SELECT * FROM telefones;
SELECT * FROM itens_do_pedido;
SELECT * FROM produtos;
SELECT * FROM categorias;
SELECT * FROM enderecos;
SELECT * FROM pedidos;
SELECT * FROM usuarios;

-- Se precisar dropar as tabelas e views:
DROP VIEW nota_fiscal;
DROP TABLE estoque;
DROP TABLE telefones;
DROP TABLE itens_do_pedido;
DROP TABLE produtos;
DROP TABLE categorias;
DROP TABLE enderecos;
DROP TABLE pedidos;
DROP TABLE usuarios;

-- Se precisar dropar trigger e função:
DROP FUNCTION verifica_estoque();
DROP TRIGGER tr_verifica_estoque ON itens_do_pedido;

-- *** THE END *** ---

-- **********************
-- TESTES EXTRAS TRIGGER:
-- **********************

UPDATE estoque SET quantidade = null WHERE id_produto = 1
INSERT INTO itens_do_pedido (id_pedido, id_produto, quantidade_produto) 
VALUES
	(10, 1, 0); -- VAI RETORNAR "Quantidade insuficiente em estoque"

UPDATE estoque SET quantidade = 1 WHERE id_produto = 2
INSERT INTO itens_do_pedido (id_pedido, id_produto, quantidade_produto) 
VALUES
	(10, 2, 3); -- VAI RETORNAR "Quantidade insuficiente em estoque"

-- Teste de verificação, se inserir o mesmo produto duas vezes no pedido, ESPERADO: não deixar inserir.
INSERT INTO itens_do_pedido (id_pedido, id_produto, quantidade_produto) VALUES
	(1, 9, 1);
