CREATE DATABASE locadora

GO

USE locadora

GO

CREATE TABLE filme(
id				INT								NOT NULL,
titulo			VARCHAR(200)					NOT NULL,
ano				INT CHECK(ano<=2021) 			NULL
PRIMARY KEY (id)
)

GO

CREATE TABLE estrela(
id				INT								NOT NULL,
nome			VARCHAR(200)					NOT NULL,
PRIMARY KEY(id)
)
GO

CREATE TABLE filme_estrela(
filme_id				INT						NOT NULL,
estrela_id				INT						NOT NULL,
PRIMARY KEY (filme_id, estrela_id),
FOREIGN KEY (filme_id)   REFERENCES filme (id),
FOREIGN KEY (estrela_id) REFERENCES estrela(id)
)

GO

CREATE TABLE dvd(
num						INT						NOT NULL,
data_fabricacao			DATE     CHECK(data_fabricacao < GETDATE())	NOT NULL,
filme_id				INT						NOT NULL
PRIMARY KEY (num)
FOREIGN KEY (filme_id) REFERENCES filme (id)
)

GO


CREATE TABLE cliente(
num_cadastro INT		NOT NULL,
nome VARCHAR(80)		NOT null,
logradouro VARCHAR(255) NOT NULL,
num INT	CHECK(num>0)	NOT NULL,
cep CHAR(8)				NULL
PRIMARY KEY (num_cadastro)
)

GO

CREATE TABLE locacao (
dvd_num				INT				NOT NULL,
clientenum_cadastro INT				NOT NULL,
data_locacao        DATE DEFAULT GETDATE()    NOT NULL,
data_devolucao      DATE			NOT NULL,
valor   DECIMAL(7,2)    CHECK(valor > 0.00)			NOT NULL
PRIMARY KEY (data_locacao, dvd_num, clientenum_cadastro) 
FOREIGN KEY (dvd_num) REFERENCES dvd(num),
FOREIGN KEY (clientenum_cadastro) REFERENCES cliente (num_cadastro),
CONSTRAINT checar_data CHECK (data_devolucao > data_locacao)
)

GO

ALTER TABLE filme ALTER COLUMN titulo VARCHAR(80)	NULL
GO

ALTER TABLE estrela ADD nome_real VARCHAR(50)		NULL
GO

INSERT INTO filme VALUES 
(1001, 'Whiplash', 2015), 
(1002, 'Birdman', 2015), 
(1003, 'Interestelar', 2014), 
(1004, 'A Culpa é das estrelas', 2014), 
(1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
(1006, 'Sing', 2016)

GO

INSERT INTO estrela VALUES 
(9901, 'Michael Keaton', 'Michael John Douglas'), 
(9902, 'Emma Stone', 'Emily Jean Stone'), 
(9903, 'Miles Teller', NULL), 
(9904, 'Steve Carell', 'Steve John Carell'), 
(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

GO

INSERT INTO filme_estrela VALUES 
(1002, 9901), 
(1002, 9902), 
(1001, 9903), 
(1005, 9904), 
(1005,9905)

GO

INSERT INTO dvd VALUES 
(10001, '2020-12-02', 1001),
(10002, '2019-10-18', 1002), 
(10003, '2020-04-03', 1003),
(10004, '2020-12-02', 1001), 
(10005, '2019-10-18', 1004),
(10006, '2020-04-03', 1002), 
(10007, '2020-12-02', 1002), 
(10008, '2019-10-19', 1002), 
(10009, '2020-04-03', 1003)

GO

INSERT INTO cliente VALUES 
(5501, 'Matilde Luiz', 'Rua Síria', 150, '03086040'),
(5502,'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'), 
(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL), 
(5504, 'Roberta Bento', 'Rya Jayme Von Rosenburg', 36, NULL), 
(5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

GO

INSERT INTO locacao VALUES 
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50), 
(10002, 5503, '2021-02-18', '2021-02-19', 3.50), 
(10002, 5505, '2021-02-20', '2021-02-23', 3.00), 
(10004, 5505, '2021-02-20', '2021-02-23', 3.00), 
(10005, 5505, '2021-02-20', '2021-02-23', 3.00), 
(10001, 5501, '2021-02-24', '2021-02-26', 3.50), 
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

GO

UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503

GO

UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

GO
UPDATE locacao
SET valor = 3.25
WHERE clientenum_cadastro = 5502 and data_locacao = '2021-02-18'

GO
UPDATE locacao
SET valor = 3.10
WHERE clientenum_cadastro = 5501 and data_locacao = '2021-02-24'

GO
UPDATE dvd
SET data_Fabricacao = '2019-07-14'
WHERE num = 10005

GO
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE id = 9903

GO
DELETE filme
WHERE titulo = 'Sing'

GO
SELECT '2014' FROM filme

GO
SELECT id, ano FROM filme
WHERE titulo = 'Birdman'


GO
SELECT id, ano from filme
WHERE titulo LIKE '%plash%'

GO
SELECT id, nome, nome_real from estrela
WHERE nome LIKE '%Steve%'

GO
SELECT filme_id, CONVERT(CHAR(10), data_fabricacao, 103) as Fab FROM dvd 
WHERE data_fabricacao >= '01-01-2020'

GO
SELECT clientenum_cadastro, dvd_num, data_locacao, data_devolucao, valor+(2.00) as valor_multa from locacao
WHERE clientenum_cadastro = 5505

GO
SELECT logradouro, num, cep from cliente
WHERE nome = 'Matilde Luiz'
GO
SELECT nome_real from estrela
WHERE nome = 'Michael Keaton'

GO
SELECT num_cadastro, nome, logradouro+' '+CONVERT(CHAR(10),num)+ ' '+cep as end_comp from cliente
where num_cadastro >= 5503

UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503

GO

UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

GO


UPDATE locacao
SET valor = 3.25
WHERE clientenum_cadastro = 5502 AND data_locacao = '20210218'

GO

UPDATE locacao
SET valor = 3.10
WHERE clientenum_cadastro = 5501 and data_locacao = '20210224'

GO

UPDATE dvd
SET data_fabricacao = '20190714'
WHERE num = 10005

GO
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE id = 9903

GO

DELETE filme
WHERE titulo = 'Sing'

GO

SELECT id, ano, 
CASE WHEN (LEN(titulo) > 10)
THEN
	SUBSTRING(titulo, 1, 10) + '...'
	 ELSE
		SUBSTRING(titulo, 1, 10)
		  END AS titulo
FROM filme
WHERE id IN
		 (
			SELECT DISTINCT filme_id
			FROM dvd
			WHERE datediff(day, data_fabricacao, '20200101') < 0
		 )

GO

SELECT data_fabricacao,
 			DATEDIFF(MONTH, '20200403', GETDATE()) AS qtd_meses_desde_fabricacao, + filme_id
FROM dvd
WHERE num = 10003

GO

SELECT dvd_num, clientenum_cadastro, data_locacao, data_devolucao,
	datediff(day, data_locacao, data_devolucao) as dias_alugados, + valor 
FROM locacao
WHERE clientenum_cadastro IN
	(
	SELECT DISTINCT num_cadastro
	FROM cliente
	WHERE nome like '%rosa%'
	)

GO

SELECT num_cadastro, 
		nome+ ', ' +logradouro+ ','+cast(num AS VARCHAR(5))+ ', '
		+SUBSTRING(cep, 1,5) + '-' +SUBSTRING(cep,6,3) AS Endereço_completo
FROM cliente
WHERE num_cadastro in
(
	SELECT DISTINCT clientenum_cadastro
	FROM locacao
	WHERE dvd_num = 10002
)

