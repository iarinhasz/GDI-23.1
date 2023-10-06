create table monstro( 
    cmf varchar(3),
    nome varchar(25) not null,
    anos_ativos int, 
    salario float(2), 
    end_quarto varchar(4), 
    end_predio varchar(4), 
    constraint pk_monstro primary key (cmf) 
);

create table sala( 
    numero int primary key, 
    localizacao_bloco varchar(10), 
    localizacao_andar int 
);

create table equipamento( 
    numero_armario int primary key, 
    nome varchar(25) 
);

create table extrator_de_gritos( 
    numero_serie varchar(25) primary key, 
    capacidade int, 
    volume_preenchido int
);

create table crianca( 
    cpf varchar(3) primary key, 
    nome varchar(25) not null, 
    data_nascimente date 
);

create table porta( 
    codigo varchar(3) primary key, 
    material varchar(25), 
    cor varchar(25) 
);

create table quarto( 
    codigo varchar(3), 
    cor_parede varchar(10), 
    metragem int, 
    constraint quarto_pk primary key(codigo), 
    constraint quarto_portas_fk foreign key (codigo) references porta on delete cascade 
);

create table medo(  
    cpf varchar(3),  
    medo varchar(30),  
    constraint medo_pk primary key (cpf, medo),  
    constraint medo_crianca_fk foreign key (cpf) references crianca on delete cascade  
);

create table gratificacao( 
    cmf varchar(3), 
    datahora timestamp, 
    valor float(2), 
    constraint gratificacao_pk primary key (cmf, datahora), 
    constraint gratificacao_monstro foreign key (cmf) references monstro(cmf) on delete cascade 
);

create table tecnico( 
    cmf varchar(3) primary key, 
    graduacao varchar(25), 
    constraint assustador_monstro foreign key (cmf) references monstro(cmf) on delete cascade 
);

create table treinar( 
    cmf_treinado varchar(3), 
    cmf_treinador varchar(3), 
    constraint treinar_pk primary key(cmf_treinado, cmf_treinador), 
    constraint assustador_monstro_treinado foreign key (cmf_treinado) references monstro(cmf) on delete cascade, 
    constraint assustador_monstro_treinador foreign key (cmf_treinador) references monstro(cmf) on delete cascade 
);

create table praticar( 
    cmf varchar(3), 
    numero_sala int, 
    numero_armario int, 
    constraint praticar_pk primary key (cmf, numero_sala, numero_armario), 
    constraint praticar_monstro foreign key (cmf) references monstro(cmf) on delete cascade, 
    constraint praticar_sala foreign key (numero_sala) references sala(numero) on delete cascade, 
    constraint praticar_equipamento foreign key(numero_armario) references equipamento(numero_armario) on delete cascade 
);

create table assustar( 
    cpf varchar(3), 
    cmf varchar(3), 
    data_susto date, 
    constraint assustar_pk primary key (cpf, cmf, data_susto), 
    constraint assustar_monstro foreign key (cmf) references monstro(cmf) on delete cascade, 
    constraint assustar_crianca foreign key (cpf) references crianca(cpf) on delete cascade 
);

create table assustador_acessa_porta( 
    cmf varchar(3), 
    codigo_porta varchar(3), 
    constraint assustador_acessa_porta_pk primary key (cmf, codigo_porta), 
    constraint assustador_acessa_porta_assustador_fk foreign key (cmf) references assustador(cmf) on delete cascade, 
    constraint assustador_acessa_porta_porta_fk foreign key (codigo_porta) references porta(codigo) on delete cascade 
);

create table assustador( 
    cmf varchar(3) primary key, 
    cmf_supervisor varchar(3) not null, 
    especialidade varchar(50), 
    constraint assustador_monstro_fk foreign key(cmf) references monstro(cmf) on delete cascade, 
    constraint assustador_monstro_supervisor_fk foreign key(cmf_supervisor) references monstro(cmf) on delete cascade 
);

create table extrair( 
    numero_serie varchar(25), 
    cpf varchar(3), 
    cmf varchar(3), 
    data_susto date, 
    data_extracao timestamp, 
    constraint extrair_pk primary key (numero_serie, cpf, cmf, data_susto, data_extracao), 
    constraint extrair_extrator_fk foreign key(numero_serie) references extrator_de_gritos(numero_serie) on delete cascade, 
    constraint extrair_assustar_fk foreign key(cpf, cmf, data_susto) references assustar(cpf, cmf, data_susto) on delete cascade  
);