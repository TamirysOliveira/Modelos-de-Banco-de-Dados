-- SHOW DATABASES;
-- CREATE DATABASE delivery;
-- USE delivery;
-- SELECT DATABASE();

/*CREATE TABLE Estado (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Uf CHAR(2) NULL,
  PRIMARY KEY(Id)
);*/

-- SHOW TABLES;
-- INSERT INTO Estado (id, uf) VALUES (1, 'RJ');
-- SELECT * FROM Estado;
-- INSERT INTO Estado (uf) VALUES ('SP');
-- SELECT * FROM Estado;
-- INSERT INTO Estado 	(uf) VALUES ('RJ');
-- DESCRIBE estado;
-- UPDATE estado SET Uf = 'MG' WHERE Id = 3;
-- DELETE FROM estado WHERE Id = 3;
-- INSERT INTO estado (Uf) VALUES ('ES');
-- SELECT Id FROM estado ORDER BY Id;

/*CREATE TABLE Produto (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Desccricao VARCHAR(200) NULL,
  Valor DECIMAL(8,2) NULL,
  Tipo VARCHAR(50) NULL,
  Estoque INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id)
);*/

-- SELECT * FROM produto;
-- SELECT Uf FROM estado ORDER BY Uf;

/*CREATE TABLE Cidade (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Estado_Id INTEGER UNSIGNED NOT NULL,
  Descrição VARCHAR(255) NULL,
  PRIMARY KEY(Id),
  INDEX Cidade_FKIndex1(Estado_Id),
  FOREIGN KEY(Estado_Id)
    REFERENCES Estado(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);*/

-- SELECT  * FROM cidade;

CREATE TABLE Entregador (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Cidade_id INTEGER UNSIGNED NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  CNH INTEGER UNSIGNED NOT NULL,
  Telefone INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id),
  INDEX Entregador_FKIndex1(Cidade_id),
  FOREIGN KEY(Cidade_id)
    REFERENCES Cidade(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);
 
--  SELECT * FROM Entregador;
 
/* CREATE TABLE Restaurante (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Cidade_id INTEGER UNSIGNED NOT NULL,
  RazaoSocial VARCHAR(100) NULL,
  Endereco VARCHAR(100) NULL,
  Telefone INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id),
  INDEX Restaurante_FKIndex1(Cidade_id),
  FOREIGN KEY(Cidade_id)
    REFERENCES Cidade(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);*/

CREATE TABLE Funcionário (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Cidade_id INTEGER UNSIGNED NOT NULL,
  Restaurante_Id INTEGER UNSIGNED NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Email VARCHAR(30)  NOT NULL,
  Senha VARCHAR(30) NOT NULL,
  Endereco VARCHAR(100) NULL,
  Telefone INTEGER UNSIGNED NULL,
  DataAdmissao DATE NULL,
  DataNascimento DATE NULL,
  PRIMARY KEY(Id),
  INDEX Funcionário_FKIndex1(Restaurante_Id),
  INDEX Funcionário_FKIndex2(Cidade_id),
  FOREIGN KEY(Restaurante_Id)
    REFERENCES Restaurante(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Cidade_id)
    REFERENCES Cidade(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Usuario (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Funcionário_Id INTEGER UNSIGNED NOT NULL,
  Email VARCHAR(70) NOT NULL,
  Senha VARCHAR(17) NOT NULL,
  PRIMARY KEY(Id),
  INDEX Usuario_FKIndex1(Funcionário_Id),
  FOREIGN KEY(Funcionário_Id)
    REFERENCES Funcionário(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Cliente (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Usuario_Id INTEGER UNSIGNED NOT NULL,
  Cidade_id INTEGER UNSIGNED NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  DataNascimento DATE NOT NULL,
  Genero CHAR(3) NULL,
  Telefone INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id),
  INDEX Cliente_FKIndex1(Cidade_id),
  INDEX Cliente_FKIndex2(Usuario_Id),
  FOREIGN KEY(Cidade_id)
    REFERENCES Cidade(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Usuario_Id)
    REFERENCES Usuario(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Pedido (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Cliente_Id INTEGER UNSIGNED NOT NULL,
  Entregador_Id INTEGER UNSIGNED NOT NULL,
  Restaurante_Id INTEGER UNSIGNED NOT NULL,
  Data_2 DATE NULL,
  TotalPedido INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id),
  INDEX Pedido_FKIndex1(Restaurante_Id),
  INDEX Pedido_FKIndex2(Entregador_Id),
  INDEX Pedido_FKIndex3(Cliente_Id),
  FOREIGN KEY(Restaurante_Id)
    REFERENCES Restaurante(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Entregador_Id)
    REFERENCES Entregador(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Cliente_Id)
    REFERENCES Cliente(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);


CREATE TABLE Endereco (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Cliente_Id INTEGER UNSIGNED NOT NULL,
  Rua VARCHAR(100) NULL,
  Numero INTEGER UNSIGNED NULL,
  Bairro VARCHAR(50) NULL,
  Complemento VARCHAR(140) NULL,
  Cep INTEGER UNSIGNED NULL,
  PontoReferencia VARCHAR(140) NULL,
  PRIMARY KEY(Id),
  INDEX Endereco_FKIndex1(Cliente_Id),
  FOREIGN KEY(Cliente_Id)
    REFERENCES Cliente(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE PedidoProduto (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Pedido_Id INTEGER UNSIGNED NOT NULL,
  Produto_Id INTEGER UNSIGNED NOT NULL,
  Quantidade INTEGER UNSIGNED NULL,
  PRIMARY KEY(Id),
  INDEX PedidoProduto_FKIndex1(Produto_Id),
  INDEX PedidoProduto_FKIndex2(Pedido_Id),
  FOREIGN KEY(Produto_Id)
    REFERENCES Produto(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Pedido_Id)
    REFERENCES Pedido(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE StatusPedido (
  Id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Pedido_Id INTEGER UNSIGNED NULL,
  Status_2 VARCHAR(20) NULL,
  PRIMARY KEY(Id),
  INDEX StatusPedido_FKIndex1(Pedido_Id),
  FOREIGN KEY(Pedido_Id)
    REFERENCES Pedido(Id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

INSERT INTO `delivery`.`statuspedido` (`Status_2`) VALUES ('Em preparação');
INSERT INTO `delivery`.`statuspedido` (`Status_2`) VALUES ('Saiu para entrega');
INSERT INTO `delivery`.`statuspedido` (`Status_2`) VALUES ('Entregue');
INSERT INTO `delivery`.`statuspedido` (`Status_2`) VALUES ('Cancelado');

SELECT * FROM statuspedido;

INSERT INTO delivery.produto (Tipo) VALUES ('Lanche');
INSERT INTO delivery.produto (Tipo) VALUES ('Pratos prontos');
INSERT INTO delivery.produto (Tipo) VALUES ('Bebidas');
INSERT INTO delivery.produto (Tipo) VALUES ('Sobremesas');

SELECT * FROM produto;