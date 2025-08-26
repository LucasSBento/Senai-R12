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
	preco_min decimal(10,2),
	preco_max decimal(10,2)
);

create table produto(
	produto_id serial primary key,
	titulo varchar(100) not null,
	preco decimal(10,2) not null,
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

create view vw_pedidos_clientes as
select 
    p.pedido_id,
    p.data_pedido,
    p.status,
    p.valor_total,
    c.nome_empresa,
    c.segmento,
    pg.metodo as metodo_pagamento,
    pg.quando_pagou,
    pg.cupom
from pedido p
inner join cliente c on p.cliente_id = c.cliente_id
left join pagamento pg on p.pedido_id = pg.pedido_id;

select * from vw_pedidos_clientes;

create view vw_produtos_setores as
select 
    pr.produto_id,
    pr.titulo,
    pr.preco,
    pr.disponibilidade,
    pr.descricao,
    s.nome as setor_nome,
    s.descricao as setor_descricao,
    s.preco_min,
    s.preco_max
from produto pr
inner join setor s on pr.setor_id = s.setor_id;

insert into cliente (email, nome_empresa, telefone, faturamento, segmento) values
('contato@alphacorp.com','alpha corp','21990000001', 1500000.00,'tecnologia'),
('vendas@betalimited.com','beta limited','21990000002', 750000.00,'varejo'),
('financeiro@gammaind.com','gamma industries','21990000003', 2300000.00,'indústria'),
('suporte@deltaco.com','delta company','21990000004', 1200000.00,'serviços'),
('info@omegasolutions.com','omega solutions','21990000005', 980000.00,'tecnologia'),
('comercial@sigmabiz.com','sigma business','21990000006', 430000.00,'educação'),
('contato@zetatech.com','zeta tech','21990000007', 1850000.00,'tecnologia'),
('adm@pharmaeta.com','pharma eta','21990000008', 2100000.00,'saúde'),
('rh@kappaconsult.com','kappa consultoria','21990000009', 600000.00,'consultoria'),
('financeiro@tetafoods.com','teta foods','21990000010', 3500000.00,'alimentos');

insert into setor (nome, descricao, preco_min, preco_max) values
('tecnologia','softwares e equipamentos de ti',500.00,15000.00),
('alimentos','produtos alimentícios em geral',10.00,500.00),
('educação','cursos e treinamentos corporativos',100.00,8000.00),
('consultoria','serviços de consultoria empresarial',500.00,20000.00),
('saúde','produtos e serviços da área da saúde',50.00,10000.00),
('varejo','produtos diversos para varejo',20.00,5000.00),
('indústria','máquinas e ferramentas industriais',1000.00,50000.00),
('serviços','serviços gerais corporativos',200.00,15000.00),
('marketing','publicidade e marketing digital',300.00,12000.00),
('logística','transporte e armazenagem',100.00,7000.00);

insert into produto (titulo, preco, disponibilidade, descricao, setor_id) values
('sistema erp cloud',12000.00,true,'erp completo em nuvem',1),
('notebook pro 15',8500.00,true,'notebook de alto desempenho',1),
('cesta básica premium',250.00,true,'kit alimentação mensal',2),
('treinamento liderança',3000.00,true,'curso intensivo para líderes',3),
('consultoria financeira',8000.00,true,'planejamento financeiro empresarial',4),
('plano saúde empresarial',450.00,true,'convênio médico por colaborador',5),
('kit varejo inicial',1500.00,true,'produtos para pequeno varejo',6),
('máquina industrial x200',25000.00,true,'equipamento para linha de produção',7),
('serviço de limpeza',1000.00,true,'contrato mensal de limpeza',8),
('campanha marketing digital',5000.00,true,'gerenciamento de tráfego pago',9);

insert into pedido (data_pedido, status, valor_total, cliente_id) values
(now(),'pendente',12000.00,1),
(now(),'pago',8500.00,2),
(now(),'enviado',250.00,3),
(now(),'entregue',3000.00,4),
(now(),'cancelado',8000.00,5),
(now(),'pago',450.00,6),
(now(),'pendente',1500.00,7),
(now(),'enviado',25000.00,8),
(now(),'entregue',1000.00,9),
(now(),'pago',5000.00,10);

insert into produto_pedido (produto_id, pedido_id, ultima_atualizacao) values
(1,1,now()),
(2,2,now()),
(3,3,now()),
(4,4,now()),
(5,5,now()),
(6,6,now()),
(7,7,now()),
(8,8,now()),
(9,9,now()),
(10,10,now());

insert into pagamento (pedido_id, metodo, cupom, quando_pagou) values
(1,'cartao de credito','desconto10',now()),
(2,'pix',null,now()),
(3,'boleto',null,now()),
(4,'cartao de credito','fretegratis',now()),
(5,'pix',null,null),
(6,'boleto',null,now()),
(7,'cartao de debito',null,null),
(8,'pix','desconto5',now()),
(9,'cartao de credito',null,now()),
(10,'pix',null,now());

select * from vw_pedidos_clientes;

select * from vw_produtos_setores;
