# EER Monstros SA

**Sala** (<ins>Número</ins>, Localização_Bloco, Localização_Andar);

**Equipamento** (<ins>Numero_Armário</ins>, Nome)

**ExtratorDeGritos** (<ins>Numero_Serie</ins>, Capacidade, Volume_Preenchido)

**Criança** (<ins>CPF</ins>, Nome!, Data_nascimento);

**Medos** (<ins>CPF_Criança, Medo</ins>)  
    CPF_Criança -> Criança (CPF)

**Porta** (<ins>Código</ins>, Material, Cor);

**Quarto** (<ins>Código</ins>, Cor_parede, Metragem)  
    Código -> Porta (Código)

**Monstro** (<ins>CMF</ins>, Nome!, Salário, Data_contratação, Endereço_Quarto, Endereço_Prédio)

**Gratificação** (<ins>CMF, Datahora</ins>, Valor)  
    CMF -> Monstro (CMF)

**Assustador** (<ins>CMF</ins>, CMF_Supervisor!, Especialidade)  
    CMF -> Monstro (CMF)  
    CMF_Supervisor -> Tecnico (CMF)

**Técnico** (<ins>CMF</ins>, Graduação)  
    CMF -> Monstro (CMF)

**Treinar** (<ins>CMF_Treinado, CMF_Treinador</ins>)  
    CMF_Treinado -> Monstro (CMF)  
    CMF_Treinador -> Monstro (CMF)

**Praticar** (<ins>CMF, Número, Numero_Armário</ins>)  
    CMF -> Monstro (CMF)  
    Número -> Sala (Número)  
    Numero_Armário -> Equipamento (Numero_Armario)

**Assustar** (<ins>CPF, CMF, Data</ins>)  
    CPF -> Criança (CPF)  
    CMF -> Assustador (CMF)

**Extrair** (<ins>Numero_Serie, CPF, CMF, Data, Data_Extração</ins>)  
    (CPF, CMF, Data) -> Assustar (CPF, CMF, Data)  
    Numero_Serie -> ExtratorDeGritos (Numero_Serie)

**Assustador_Acessa_Porta** (<ins>CMF, Código</ins>)  
    CMF -> Assustador (CMF)  
    Código -> Porta (Código)
