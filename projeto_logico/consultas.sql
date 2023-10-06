-- Seu projeto deve ter todos os tipos de consultas abaixo
--ok  -Group by/Having
--ok -Junção interna
--ok -Junção externa
--ok -Semi junção
--ok -Anti-junção
--ok -Subconsulta do tipo escalar
--ok -Subconsulta do tipo linha
--ok -Subconsulta do tipo tabela
--ok -Operação de conjunto

-- todos os monstros que assustaram uma criança com medo de "professor".
SELECT DISTINCT m.cmf, m.nome
FROM monstro m
INNER JOIN assustar a ON m.cmf = a.cmf
INNER JOIN medo me ON a.cpf = me.cpf
WHERE me.medo = 'professor';

-- monstros que praticam em salas localizadas no bloco A
SELECT m.cmf, m.nome
FROM monstro m
WHERE m.cmf IN (
    SELECT DISTINCT p.cmf
    FROM praticar p
    INNER JOIN sala s ON p.numero_sala = s.numero
    WHERE s.localizacao_bloco = 'A'
);

-- monstros com salario maior que a media, como uma subconsulta escalar: 
SELECT m.nome, m.salario
FROM monstro m
WHERE m.salario > (SELECT AVG(m2.salario) FROM monstro m2)
ORDER BY m.salario DESC;

-- Lista os monstros e suas respectivas salas, incluindo salas sem monstros 
SELECT m.cmf, m.nome, s.numero
FROM monstro m
LEFT JOIN praticar p ON m.cmf = p.cmf
RIGHT JOIN sala s ON p.numero_sala = s.numero;

-- monstros que acessam mais de uma porta
SELECT ap.cmf, m.nome, COUNT(ap.codigo_porta), AS portas
    FROM assustador_acessa_porta ap
    INNER JOIN monstro m ON (ap.cmf = m.cmf)
    GROUP BY ap.cmf = m.nome
    HAVING COUNT(ap.codigo_porta) > 1

-- crianças sem medo
select c.cpf, c.nome
    from medo m
    full outer join crianca c on m.cpf = c.cpf
    where m.cpf IS NULL

--
SELECT m.nome
FROM monstro m
WHERE EXISTS (
    SELECT g.cmf
    FROM gratificacao g
    WHERE g.cmf = m.cmf
    GROUP BY g.cmf
    HAVING COUNT(*) > 2
); 

-- tecnicos que acessaram portas
SELECT m.nome
FROM monstro m
JOIN tecnico t ON m.cmf = t.cmf

INTERSECT

SELECT m.nome
FROM monstro m
JOIN assustador_acessa_porta ap ON m.cmf = ap.cmf;

-- busca o monstro que assustou uma criança em um determinado dia
SELECT c.nome as crianca_assustada, 
       (SELECT m.nome
        FROM monstro m
        JOIN assustar a ON m.cmf = a.cmf
        WHERE a.cpf = c.cpf
        AND a.data_susto = TO_DATE('2011-08-14', 'YYYY-MM-DD')
       ) as monstro_assustador
FROM crianca c
WHERE c.cpf = '378'


-- força um piso salarial aos monstros
CREATE OR REPLACE TRIGGER salario_minimo_monstro
BEFORE INSERT OR UPDATE ON monstro
FOR EACH ROW
DECLARE
  salario_minimo NUMBER := 1000; -- salario minimo
BEGIN
  IF :new.salario < salario_minimo THEN
     DBMS_OUTPUT.PUT_LINE('Salario tem que ser maior que o salario minimo');
  END IF;
END;


-- retorna a soma das gratificaçoes de um monstro
CREATE OR REPLACE FUNCTION calcular_gratificao(cmf_in VARCHAR)
RETURN FLOAT
AS
    gratificacao_total FLOAT := 0;
BEGIN
    SELECT SUM(valor) INTO gratificacao_total
    FROM gratificacao
    WHERE cmf = cmf_in;
    RETURN gratificacao_total;
END;


CREATE OR REPLACE TRIGGER validar_data_nascimento
BEFORE INSERT OR UPDATE ON crianca
FOR EACH ROW
BEGIN
    IF :new.data_nascimente > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'A criança ainda nem nasceu!');
    END IF;
END;

-- remove um acesso à uma porta
CREATE OR REPLACE PROCEDURE remover_acesso(cmf_in VARCHAR, codigo_porta_in VARCHAR)
AS
BEGIN
    DELETE FROM assustador_acessa_porta
    WHERE cmf = cmf_in AND codigo_porta = codigo_porta_in;
END;


-- aponta um supervisor
CREATE OR REPLACE PROCEDURE apontar_supervisor(cmf_supervisionado IN VARCHAR2, cmf_supervisor IN VARCHAR2)
AS
BEGIN
    UPDATE assustador
    SET cmf_supervisor = cmf_supervisor
    WHERE cmf = cmf_supervisionado;
END;


-- function para calcular a idade de uma criança
CREATE OR REPLACE FUNCTION calcular_idade(cpf_in IN VARCHAR2) RETURN NUMBER IS
    data_nasc DATE;
    idade NUMBER;
BEGIN
    SELECT data_nascimente INTO data_nasc
    FROM crianca
    WHERE cpf = cpf_in;

    -- calcular idade em anos
    idade := FLOOR(MONTHS_BETWEEN(SYSDATE, data_nasc) / 12);
RETURN idade;
END;

SELECT cpf, calcular_idade(cpf), nome, data_nascimente
FROM crianca

-- Busca os monstros que receberam gratificação
SELECT m.nome
FROM monstro m
WHERE EXISTS (
    SELECT g.cmf
    FROM gratificacao g
    WHERE g.cmf = m.cmf
)

-- Busca todas as crianças com medo de banco de dados que foram assustadas por monstros especializados em dar nota baixa
SELECT m.nome AS monstro, c.nome AS crianca
FROM monstro m
JOIN assustador ass ON m.cmf = ass.cmf
JOIN assustar a ON m.cmf = a.cmf
JOIN crianca c ON a.cpf = c.cpf
JOIN medo me ON c.cpf = me.cpf

-- Busca os assustadores que acessaram portas
SELECT m.nome
FROM monstro m
INNER JOIN assustador a on m.cmf = a.cmf

INTERSECT

SELECT m.nome
FROM monstro m
INNER JOIN assustador_acessa_porta ap ON m.cmf = ap.cmf

-- Operação de conjuntos