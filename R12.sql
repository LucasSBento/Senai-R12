create database r12business;

create table cliente(
	cliente_id serial primary key,
	email varchar(100) unique not null,
	nome_empresa varchar(100) not null,
	telefone varchar(20) not null unique,
	faturamento decimal(12,2) not null,
	segmento varchar(100) not null
);

create table setor(
	setor_id serial primary key,
	nome varchar(100) not null,
	descricao text,
	preco_min decimal(6,2),
	preco_max decimal(6,2)
);

create table produto(
	produto_id serial primary key,
	titulo varchar(100) not null,
	preco decimal(6,2) not null,
	disponibilidade boolean,
	descricao text,
	setor_id int, foreign key (setor_id) references setor(setor_id)
);

create table pedido(
	pedido_id serial primary key,
    data_pedido timestamp,
    status varchar(20) not null,
    valor_total decimal(10,2) not null,
	cliente_id int not null, foreign key (cliente_id) references cliente(cliente_id)
);

create table produto_pedido(
	produto_id int not null,
	pedido_id int not null,
	ultima_atualizacao timestamp,
	primary key (produto_id, pedido_id),
	foreign key (produto_id) references produto(produto_id),
	foreign key (pedido_id) references pedido(pedido_id)
);

create table pagamento(
	pagameno_id serial primary key,
	pedido_id int not null, foreign key (pedido_id) references pedido(pedido_id),
	metodo varchar(100) not null,
	cupom varchar(100),
	quando_pagou timestamp
);
