import random
import string
from faker import Faker  # You may need to install this package using pip

fake = Faker()

global cmfs, cpfs, numero_series, portas, quartos, equipamentos, numero_armarios, numero_salas, data_sustos
assustars = []

medos = ["palhaco", "cobra", "redemoinho", "banco de dados", "professor", "nota baixa", "pessoas", "computador"]
cores = ("verde", "azul", "vermelho", "preto", "branco", "laranja", "amarelo")

def main():
   
    num_rows = 30

    global cmfs, cpfs, numero_series, portas, quartos, equipamentos, numero_armarios, numero_salas, data_sustos
    cmfs = tuple([randstr(3) for _ in range(num_rows)])
    cpfs = tuple([random.randint(100, 999) for _ in range(num_rows)])
    numero_series = tuple([f"{randstr(3)}-{random.randint(100, 999)}" for _ in range(num_rows)])
    numero_armarios = tuple([random.randint(100, 999) for _ in range(num_rows)])
    portas = tuple([randstr(3) for _ in range(num_rows)])
    quartos = tuple([randstr(3) for _ in range(num_rows)])
    equipamentos = tuple(["bajulador", "encrencador", "jubijabor", "escumador", "peso", "cordao", "limpador", "bastao", "taco", "toalha", "travesseiro", "teclado", "caixa", "foto feia"])
    data_sustos = tuple([fake.date_of_birth(minimum_age=5, maximum_age=12) for _ in range(num_rows)])
    numero_salas = tuple([fake.unique.random_int(min=1, max=100) for _ in range(num_rows)])

    print (cmfs)
    print (cpfs)
    print (numero_series)
    print (portas)

    inserts = []
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_monstro_data())
    fake.unique.clear()

   
    for _ in range(num_rows):
        inserts.append(generate_sala_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_equipamento_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_extrator_de_gritos_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_crianca_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_porta_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_quarto_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_medo_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_gratificacao_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_tecnico_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_treinar_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_praticar_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_assustar_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_assustador_acessa_porta_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_assustador_data())
    fake.unique.clear()

    for _ in range(num_rows):
        inserts.append(generate_extrair_data())
    fake.unique.clear()

    with open("pov.sql", "w") as file:
        for insert in inserts:
            file.write(insert + "\n")


def randstr(size=3, chars=string.ascii_uppercase):
    return f"{''.join(random.choice(chars) for _ in range(size))}"

def generate_monstro_data():
    cmf = fake.unique.random_element(cmfs)  # Generating a random 3-digit number
    nome = fake.first_name()
    anos_ativos = random.randint(1, 30)
    salario = round(random.uniform(1000, 10000), 2)  # Random float between 1000 and 10000
    end_quarto = fake.random_int(min=1000, max=9999)  # Generating a random 4-digit number
    end_predio = fake.random_int(min=1000, max=9999)  # Generating a random 4-digit number
    return f"INSERT INTO monstro VALUES ('{cmf}', '{nome}', {anos_ativos}, {salario}, '{end_quarto}', '{end_predio}');"

def generate_sala_data():
    numero = fake.unique.random_element(numero_salas)
    localizacao_bloco = fake.random_element(elements=("A", "B", "C", "D", "E"))
    localizacao_andar = fake.random_int(min=1, max=10)
    return f"INSERT INTO sala VALUES ({numero}, '{localizacao_bloco}', {localizacao_andar});"


def generate_equipamento_data():
    numero_armario = fake.unique.random_element(numero_armarios)
    nome = fake.random_element(equipamentos)
    return f"INSERT INTO equipamento VALUES ({numero_armario}, '{nome}');"

def generate_extrator_de_gritos_data():
    numero_serie = fake.unique.random_element(numero_series)
    capacidade = fake.random_int(min=1, max=100)
    volume_preenchido = fake.random_int(min=0, max=capacidade)
    return f"INSERT INTO extrator_de_gritos VALUES ('{numero_serie}', {capacidade}, {volume_preenchido});"

def generate_crianca_data():
    cpf = fake.unique.random_element(cpfs)
    nome = fake.first_name()
    data_nascimento = fake.date_of_birth(minimum_age=5, maximum_age=12)
    return f"INSERT INTO crianca VALUES ('{cpf}', '{nome}', to_date('{data_nascimento}', 'YYYY-MM-DD'));"

def generate_porta_data():
    codigo = fake.unique.random_element(portas)
    material = fake.random_element(elements=("Wood", "Metal", "Glass", "Plastic"))
    cor = fake.random_element(cores)
    return f"INSERT INTO porta VALUES ('{codigo}', '{material}', '{cor}');"

def generate_quarto_data():
    codigo = fake.unique.random_element(portas)
    cor_parede = fake.random_element(cores)
    metragem = fake.random_int(min=10, max=100)
    return f"INSERT INTO quarto VALUES ('{codigo}', '{cor_parede}', {metragem});"

def generate_medo_data():
    cpf = fake.random_element(cpfs)
    medo = fake.random_element(medos)
    return f"INSERT INTO medo VALUES ('{cpf}', '{medo}');"

def generate_gratificacao_data():
    cmf = fake.random_element(cmfs)
    datahora = fake.date_time_between(start_date="-1y", end_date="now")
    valor = round(random.uniform(100, 1000), 2)
    return f"INSERT INTO gratificacao VALUES ('{cmf}', to_date('{datahora}', 'yyyy/mm/dd hh24:mi:ss'), {valor});"

def generate_tecnico_data():
    cmf = fake.random_element(cmfs)
    graduacao = fake.random_element(("administracao", "engenharia", "teoria do susto", "filosofia"))
    return f"INSERT INTO tecnico VALUES ('{cmf}', '{graduacao}');"

def generate_treinar_data():
    cmf_treinado = fake.unique.random_element(cmfs)
    cmf_treinador = fake.unique.random_element(cmfs)
    return f"INSERT INTO treinar VALUES ('{cmf_treinado}', '{cmf_treinador}');"

def generate_praticar_data():
    cmf = fake.random_element(cmfs)
    numero_sala = fake.random_element(numero_salas)
    numero_armario = fake.random_element(numero_armarios)
    return f"INSERT INTO praticar VALUES ('{cmf}', {numero_sala}, {numero_armario});"

def generate_assustar_data():
    cpf = fake.random_element(cpfs)
    cmf = fake.random_element(cmfs)
    data_susto = fake.unique.random_element(data_sustos)
    global assustars
    assustars.append((cpf, cmf, data_susto))
    return f"INSERT INTO assustar VALUES ('{cpf}', '{cmf}', to_date('{data_susto}', 'YYYY-MM-DD'));"

def generate_assustador_acessa_porta_data():
    cmf = fake.random_element(cmfs)
    codigo_porta = fake.random_element(portas)
    return f"INSERT INTO assustador_acessa_porta VALUES ('{cmf}', '{codigo_porta}');"

def generate_assustador_data():
    cmf = fake.unique.random_element(cmfs)
    cmf_supervisor = fake.random_element(cmfs)
    especialidade = fake.random_element("crianças", "adolescentes", "terror", "sustos de palhaço", "dar nota baixa", "susto existencial")
    return f"INSERT INTO assustador VALUES ('{cmf}', '{cmf_supervisor}', '{especialidade}');"

def generate_extrair_data():
    cpf, cmf, data_susto = fake.unique.random_element(tuple(assustars))
    numero_serie = fake.random_element(numero_series)
    data_extracao = fake.date_time_between(start_date="-1y", end_date="now")
    return f"INSERT INTO extrair VALUES ('{numero_serie}', '{cpf}', '{cmf}', to_date('{data_susto}', 'YYYY-MM-DD'), to_date('{data_extracao}', 'yyyy/mm/dd hh24:mi:ss'));"


main()