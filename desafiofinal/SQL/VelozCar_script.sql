CREATE TABLE IF NOT EXISTS `Clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL UNIQUE,
  `endereco` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `data_cadastro` DATETIME NOT NULL,
  PRIMARY KEY (`id_cliente`)
);

CREATE TABLE IF NOT EXISTS `Funcionarios` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL UNIQUE,
  `cargo` VARCHAR(50) NOT NULL,
  `data_admissao` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`id_funcionario`)
);

CREATE TABLE IF NOT EXISTS `Veiculos` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(7) NOT NULL UNIQUE,
  `modelo` VARCHAR(100) NOT NULL,
  `cor` VARCHAR(30) NOT NULL,
  `ano_fabricacao` INT NOT NULL,
  `valor_diaria` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(20) NOT NULL COMMENT 'Disponível, Alugado, Em Manutenção',
  PRIMARY KEY (`id_veiculo`)
);

CREATE TABLE IF NOT EXISTS `Manutencoes` (
  `id_manutencao` INT NOT NULL AUTO_INCREMENT,
  `descricao_servico` TEXT NOT NULL,
  `custo` DECIMAL(10,2) NOT NULL,
  `data_manutencao` DATE NOT NULL,
  `responsavel` VARCHAR(150) NOT NULL,
  `data_conclusao` DATE NULL,
  `id_veiculo` INT NOT NULL,
  PRIMARY KEY (`id_manutencao`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `Veiculos`(`id_veiculo`)
);

CREATE TABLE IF NOT EXISTS `Alugueis` (
  `id_aluguel` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(20) NOT NULL COMMENT 'Ativo, Finalizado, Atrasado',
  `id_cliente` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `id_veiculo` INT NOT NULL,
  PRIMARY KEY (`id_aluguel`),
  FOREIGN KEY (`id_cliente`) REFERENCES `Clientes`(`id_cliente`),
  FOREIGN KEY (`id_funcionario`) REFERENCES `Funcionarios`(`id_funcionario`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `Veiculos`(`id_veiculo`)
);

CREATE TABLE IF NOT EXISTS `Pagamentos` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `valor_pagamento` DECIMAL(10,2) NOT NULL,
  `data_pagamento` DATETIME NOT NULL,
  `metodo_pagamento` VARCHAR(20) NOT NULL COMMENT 'Cartão, PIX, Boleto',
  `status_pagamento` VARCHAR(20) NOT NULL COMMENT 'Concluído, Pendente, Cancelado',
  `id_aluguel` INT NOT NULL,
  PRIMARY KEY (`id_pagamento`),
  FOREIGN KEY (`id_aluguel`) REFERENCES `Alugueis`(`id_aluguel`)
);


INSERT INTO `Clientes` (`nome_completo`, `cpf`, `endereco`, `telefone`, `email`, `data_cadastro`) VALUES
('Ana Silva', '11122233344', 'Rua das Flores, 123', '83988887777', 'ana.silva@email.com', '2024-01-10 09:00:00'),
('Bruno Costa', '22233344455', 'Av. Principal, 456', '83988886666', 'bruno.costa@email.com', '2024-01-15 14:30:00'),
('Carla Dias', '33344455566', 'Travessa Sol, 789', '83988885555', 'carla.dias@email.com', '2024-02-01 11:20:00'),
('Daniel Farias', '44455566677', 'Rua da Praia, 101', '83988884444', 'daniel.farias@email.com', '2024-02-20 16:00:00'),
('Eduarda Lima', '55566677788', 'Av. Oceano, 202', '83988883333', 'eduarda.lima@email.com', '2024-03-05 10:15:00'),
('Fábio Melo', '66677788899', 'Rua Central, 303', '83988882222', 'fabio.melo@email.com', '2024-03-12 18:00:00'),
('Gabriela Nunes', '77788899900', 'Travessa Verde, 404', '83988881111', 'gabriela.nunes@email.com', '2024-04-02 08:45:00'),
('Hugo Santos', '88899900011', 'Av. das Palmeiras, 505', '83988880000', 'hugo.santos@email.com', '2024-04-18 13:00:00');


INSERT INTO `Funcionarios` (`nome_completo`, `cpf`, `cargo`, `data_admissao`, `email`) VALUES
('João Pereira', '12312312311', 'Gerente de Vendas', '2022-05-10', 'joao.pereira@velozcar.com'),
('Maria Oliveira', '23423423422', 'Atendente', '2023-02-20', 'maria.oliveira@velozcar.com'),
('Pedro Almeida', '34534534533', 'Atendente', '2023-08-01', 'pedro.almeida@velozcar.com'),
('Sofia Ferreira', '45645645644', 'Coordenadora de Frota', '2022-11-15', 'sofia.ferreira@velozcar.com');


INSERT INTO `Veiculos` (`placa`, `modelo`, `cor`, `ano_fabricacao`, `valor_diaria`, `status`) VALUES
('RST1A23', 'Fiat Mobi', 'Branco', 2023, 95.50, 'Disponível'),
('STU2B34', 'Hyundai HB20', 'Prata', 2022, 110.00, 'Disponível'),
('UVW3C45', 'Chevrolet Onix', 'Preto', 2023, 115.75, 'Alugado'),
('WXY4D56', 'Jeep Renegade', 'Cinza', 2023, 180.00, 'Alugado'),
('YZA5E67', 'Fiat Cronos', 'Vermelho', 2022, 130.50, 'Disponível'),
('BCD6F78', 'Renault Kwid', 'Branco', 2023, 90.00, 'Em Manutenção'),
('CDE7G89', 'Volkswagen Gol', 'Prata', 2021, 105.00, 'Disponível'),
('EFG8H90', 'Toyota Corolla', 'Preto', 2023, 220.00, 'Alugado');

INSERT INTO `Manutencoes` (`descricao_servico`, `custo`, `data_manutencao`, `responsavel`, `data_conclusao`, `id_veiculo`) VALUES
('Troca de óleo e filtros', 350.00, '2024-05-10', 'Oficina Auto Rápido', '2024-05-11', 2),
('Revisão completa 20.000km', 650.00, '2024-06-01', 'Concessionária Autorizada', '2024-06-03', 4),
('Alinhamento e balanceamento', 180.00, '2024-06-15', 'Centro Automotivo Veloz', '2024-06-15', 1),
('Troca de pastilhas de freio', 420.00, '2024-07-20', 'Oficina Auto Rápido', NULL, 6);

INSERT INTO `Alugueis` (`data_inicio`, `data_fim`, `valor_total`, `status`, `id_cliente`, `id_funcionario`, `id_veiculo`) VALUES
('2024-07-01 10:00:00', '2024-07-05 10:00:00', 463.00, 'Finalizado', 1, 2, 3),
('2024-07-10 14:00:00', '2024-07-17 14:00:00', 1260.00, 'Finalizado', 2, 3, 4),
('2024-08-01 09:00:00', '2024-08-10 09:00:00', 1050.00, 'Finalizado', 3, 2, 7),
('2024-08-20 15:00:00', '2024-08-23 15:00:00', 347.25, 'Ativo', 4, 3, 3),
('2024-09-01 11:00:00', '2024-09-06 11:00:00', 900.00, 'Ativo', 5, 2, 4),
('2024-09-05 18:00:00', '2024-09-15 18:00:00', 2200.00, 'Ativo', 6, 3, 8),
('2024-09-10 12:00:00', '2024-09-12 12:00:00', 220.00, 'Ativo', 7, 2, 2);

INSERT INTO `Pagamentos` (`valor_pagamento`, `data_pagamento`, `metodo_pagamento`, `status_pagamento`, `id_aluguel`) VALUES
(463.00, '2024-07-01 10:05:00', 'Cartão', 'Concluído', 1),
(1260.00, '2024-07-10 14:10:00', 'PIX', 'Concluído', 2),
(1050.00, '2024-08-01 09:03:00', 'Cartão', 'Concluído', 3),
(347.25, '2024-08-20 15:05:00', 'Cartão', 'Concluído', 4),
(900.00, '2024-09-01 11:02:00', 'PIX', 'Concluído', 5),
(1100.00, '2024-09-05 18:10:00', 'PIX', 'Concluído', 6),
(1100.00, '2024-10-05 18:00:00', 'Boleto', 'Pendente', 6),
(220.00, '2024-09-10 12:00:00', 'Cartão', 'Concluído', 7);

UPDATE Veiculos
SET status = 'Disponível'
WHERE id_veiculo = 6;

UPDATE Manutencoes
SET data_conclusao = '2024-09-13'
WHERE id_manutencao = 4;


UPDATE Alugueis
SET status = 'Finalizado'
WHERE id_aluguel = 4;

UPDATE Veiculos
SET status = 'Disponível'
WHERE id_veiculo = 3;

-- agregação/agrupamento (uma por tabela)

-- quantos clientes foram cadastrados por ano
SELECT YEAR(data_cadastro) AS ano, COUNT(id_cliente) AS total_clientes
FROM Clientes
GROUP BY YEAR(data_cadastro)
ORDER BY ano;

-- Agrupar funcionários por cargo.
SELECT cargo, COUNT(id_funcionario) AS quantidade_funcionarios
FROM Funcionarios
GROUP BY cargo;

-- Calcular o valor médio da diária dos veículos por ano de fabricação.
SELECT ano_fabricacao, AVG(valor_diaria) AS media_diaria
FROM Veiculos
GROUP BY ano_fabricacao
ORDER BY ano_fabricacao DESC;

-- Somar o custo total das manutenções por veículo.
SELECT id_veiculo, SUM(custo) AS custo_total_manutencao
FROM Manutencoes
GROUP BY id_veiculo;

-- Consulta 5: Contar quantos aluguéis estão em cada status.
SELECT status, COUNT(id_aluguel) AS total_alugueis
FROM Alugueis
GROUP BY status;

-- Total arrecadado por método de pagamento.
SELECT metodo_pagamento, SUM(valor_pagamento) AS total_arrecadado
FROM Pagamentos
WHERE status_pagamento = 'Concluído'
GROUP BY metodo_pagamento;

-- Operações de JOIN

-- Listar os aluguéis ativos, mostrando o nome do cliente,
-- o modelo do veículo e o nome do funcionário responsável.
SELECT
    A.id_aluguel,
    C.nome_completo AS cliente,
    V.modelo AS veiculo,
    F.nome_completo AS funcionario,
    A.data_fim
FROM Alugueis AS A
INNER JOIN Clientes AS C ON A.id_cliente = C.id_cliente
INNER JOIN Veiculos AS V ON A.id_veiculo = V.id_veiculo
INNER JOIN Funcionarios AS F ON A.id_funcionario = F.id_funcionario
WHERE A.status = 'Ativo';

-- (LEFT JOIN): Exibir todos os veículos e, para aqueles que já tiveram
-- manutenção, mostrar a descrição e o custo do serviço.
SELECT
    V.placa,
    V.modelo,
    V.status,
    M.descricao_servico,
    M.custo,
    M.data_manutencao
FROM Veiculos AS V
LEFT JOIN Manutencoes AS M ON V.id_veiculo = M.id_veiculo
ORDER BY V.placa;