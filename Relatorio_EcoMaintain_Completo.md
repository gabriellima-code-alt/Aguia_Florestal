# Relatório Descritivo Completo do Sistema EcoMaintain

**Autor:** Manus AI
**Data:** 06 de Março de 2026

## 1. Introdução

Este documento detalha as funcionalidades e melhorias implementadas no sistema EcoMaintain, transformando-o em uma plataforma robusta para a gestão de manutenção preventiva e corretiva. As atualizações foram projetadas para otimizar a operação do PCM (Planejamento e Controle da Manutenção) e dos manutentores, garantindo maior controle, segurança, produtividade e inteligência de dados.

Todas as modificações foram realizadas mantendo a estrutura original do sistema, garantindo a compatibilidade com o ambiente de deploy existente (Vercel e Neon) e a preservação dos dados já cadastrados.

## 2. Novas Funcionalidades e Aprimoramentos

O sistema EcoMaintain foi enriquecido com as seguintes funcionalidades:

### 2.1. Checklist do Manutentor Aprimorado

A funcionalidade de checklist para manutenções preventivas foi significativamente melhorada para oferecer maior flexibilidade e registro detalhado:

*   **Botões de Conformidade**: O checkbox simples foi substituído por botões de **"Conforme"** (verde) e **"Não Conforme"** (vermelho) para cada item do checklist, permitindo um registro mais claro do status.
*   **Campo de Observação Dinâmico**: Ao selecionar **"Não Conforme"**, um campo de texto é exibido automaticamente, permitindo ao manutentor descrever o problema encontrado ou a não conformidade.
*   **Adição de Itens Personalizados**: O manutentor agora pode incluir novos itens personalizados no checklist durante a execução da manutenção, com seus próprios botões de conformidade e campos de observação. Esses itens podem ser removidos antes da finalização.
*   **Geração de Laudo Técnico em PDF**: Ao finalizar o checklist, o sistema gera automaticamente um **Laudo Técnico em PDF** detalhado. Este laudo inclui todos os dados da manutenção, o status de cada item (conforme/não conforme), as observações registradas e os itens adicionados manualmente.
*   **Persistência do Laudo**: O laudo é salvo no banco de dados Neon em dois formatos: `laudo_dados` (JSON com as respostas e observações) e `laudo_pdf` (o arquivo PDF em formato Base64).
*   **Histórico no PCM**: No painel do PCM, na tabela de agendamentos preventivos, um botão **"📄 Laudo"** permite baixar o documento PDF a qualquer momento para agendamentos concluídos.

### 2.2. Manuais na Nuvem

A gestão de manuais foi migrada do armazenamento local (IndexedDB) para o banco de dados Neon, garantindo acessibilidade e gerenciamento centralizado:

*   **Migração para Neon**: Todos os manuais agora são armazenados no banco de dados Neon, permitindo que sejam acessados de qualquer dispositivo.
*   **Gerenciamento pelo PCM**: O PCM pode adicionar, visualizar, atualizar e excluir manuais diretamente pelo sistema.
*   **Acessibilidade Multi-dispositivo**: Manutentores e o PCM podem consultar os manuais a qualquer momento, independentemente do dispositivo utilizado.

### 2.3. Gestão de Estoque com Trava de Segurança

Foi implementada uma validação crítica para o consumo de peças, evitando inconsistências no estoque:

*   **Validação em Tempo Real**: O sistema impede que o manutentor registre o uso de uma quantidade de peças maior do que a disponível no estoque.
*   **Alertas Claros**: Em caso de tentativa de consumo excessivo, o sistema exibe uma mensagem de erro informando a quantidade disponível e a quantidade que o manutentor tentou utilizar.

### 2.4. Relatório Profissional de Ordem de Serviço (O.S.) para o PCM

O relatório de O.S. foi aprimorado para fornecer uma visão completa e profissional da manutenção corretiva:

*   **Cálculo de Custos**: O relatório calcula automaticamente o custo total das peças utilizadas em cada O.S., com base no valor unitário cadastrado no estoque.
*   **Análise de Tempos**: Inclui o tempo total da O.S. (da criação à finalização) e o tempo em que a O.S. ficou em status de pendência.
*   **Evidências Fotográficas**: As fotos tiradas no início (problema) e no final (solução) da O.S. são exibidas diretamente no relatório.
*   **Assinatura Digital Obrigatória**: A assinatura digital do manutentor é agora um requisito obrigatório para a finalização da O.S., garantindo a responsabilidade pela execução.
*   **Identificação do Manutentor**: O e-mail do manutentor que finalizou a O.S. é exibido no relatório para fins de auditoria e contato.

### 2.5. Controle de Produtividade (PPR) Inteligente

Uma funcionalidade complexa para calcular o tempo de trabalho efetivo dos manutentores foi implementada, visando o cálculo de PPR:

*   **Cronometragem Inteligente**: O sistema registra o tempo de trabalho efetivo do manutentor, iniciando e pausando a contagem com base nas ações do usuário.
*   **Pausas Justificadas**: O manutentor pode registrar pausas (ex: falta de peças), e o sistema desconta esse tempo do cálculo de produtividade. O motivo da pausa é registrado.
*   **Consideração de Turnos e Almoço**: O sistema pausa automaticamente a contagem durante o horário de almoço e ao final do turno de trabalho configurado para o manutentor, garantindo que apenas o tempo produtivo seja contabilizado.
*   **Relatório de Produtividade em PDF**: O PCM pode gerar um relatório detalhado de produtividade, filtrando por **manutentor** e **período**. O relatório inclui:
    *   Total de horas trabalhadas no período.
    *   Total de tempo em pausa.
    *   Média diária de produtividade.
    *   Detalhamento diário das horas trabalhadas e em pausa.

### 2.6. Relatório de Custos de Estoque

Um novo relatório financeiro para o PCM, focado nos gastos com peças:

*   **Filtro por Período**: Permite analisar os custos de estoque em qualquer intervalo de datas.
*   **Custo Total do Período**: Exibe o valor total gasto com peças no período selecionado.
*   **Custos por Mês**: Apresenta o gasto total de peças agrupado por mês.
*   **Custos por Peça**: Detalha o custo total e a quantidade utilizada de cada tipo de peça.
*   **Exportação em PDF**: Gera um documento profissional com todas as informações financeiras.

### 2.7. Histórico de Máquinas Detalhado

A aba de histórico de máquinas no painel do PCM foi aprimorada para oferecer uma visão completa das intervenções:

*   **Histórico de O.S. por Máquina**: Ao visualizar uma máquina, todas as Ordens de Serviço (O.S.) relacionadas a ela são exibidas, detalhando o problema, a solução e as datas das intervenções.
*   **Controle de Ativos**: Permite ao PCM ter um controle mais apurado sobre a saúde e o histórico de manutenção de cada equipamento.

### 2.8. Análise de Falhas Inteligente

Um relatório analítico para identificar padrões e otimizar a manutenção preditiva:

*   **Máquinas com Mais Falhas**: Identifica e lista as máquinas que apresentaram o maior número de falhas em um determinado período.
*   **Falhas Recorrentes**: Analisa as descrições das O.S. para agrupar e quantificar os tipos de falhas que mais se repetem, ajudando a identificar problemas crônicos.
*   **Períodos Críticos**: Permite identificar semanas ou meses com maior incidência de falhas.
*   **Exportação em PDF**: Gera um relatório com gráficos e tabelas para facilitar a visualização e tomada de decisão.

### 2.9. Relatório de O.S. Avançado (Ciclo de Vida Completo)

Este é o relatório mais abrangente, fornecendo uma análise profunda do ciclo de vida de cada Ordem de Serviço:

*   **Filtro por Período**: Permite visualizar as O.S. dentro de um intervalo de datas específico.
*   **Visão Geral por Mês**: Lista as O.S. agrupadas por mês, com um resumo do total.
*   **Detalhes Expandidos por O.S.**: Ao clicar em uma O.S., um relatório detalhado em PDF é gerado, contendo:
    *   **Tempo Total da O.S.**: Da criação à finalização.
    *   **Tempo em Pendência**: Quanto tempo a O.S. ficou parada aguardando liberação.
    *   **Tempo de Trabalho Efetivo**: As horas que os manutentores realmente dedicaram àquela O.S., considerando os registros de iniciar/pausar e descontando pausas e horários de almoço.
    *   **Tempo Pós-Liberação**: Quanto tempo levou para a O.S. ser finalizada após sair de um estado de pendência.
    *   Todas as informações já presentes no relatório profissional de O.S. (descrição, solução, fotos, custos, assinaturas).

## 3. Estrutura do Banco de Dados (Neon - PostgreSQL)

Para suportar todas as novas funcionalidades, a estrutura do banco de dados foi atualizada. As tabelas existentes foram modificadas com novas colunas e novas tabelas foram adicionadas. Abaixo, o script SQL completo para criação/atualização das tabelas:

```sql
-- Script SQL para criação/atualização das tabelas do EcoMaintain no Neon (PostgreSQL)

-- Tabela de Usuários
CREATE TABLE IF NOT EXISTS usuarios (
  id TEXT PRIMARY KEY,
  nome TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  senha TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'manutentor',
  turno_inicio TEXT,
  turno_fim TEXT,
  almoco_inicio TEXT,
  almoco_fim TEXT,
  data_cadastro TIMESTAMP DEFAULT NOW()
);

-- Tabela de Máquinas
CREATE TABLE IF NOT EXISTS maquinas (
  id TEXT PRIMARY KEY,
  nome TEXT NOT NULL,
  especificacoes TEXT,
  historico TEXT,
  data_cadastro TIMESTAMP DEFAULT NOW()
);

-- Tabela de Peças
CREATE TABLE IF NOT EXISTS pecas (
  id TEXT PRIMARY KEY,
  nome TEXT NOT NULL,
  quantidade INTEGER NOT NULL DEFAULT 0,
  valor NUMERIC(10,2) DEFAULT 0,
  minimo_estoque INTEGER DEFAULT 0,
  data_cadastro TIMESTAMP DEFAULT NOW()
);

-- Tabela de Ordens de Serviço
CREATE TABLE IF NOT EXISTS ordens_servico (
  id TEXT PRIMARY KEY,
  maquina_id TEXT,
  descricao TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'ativa',
  manutentor TEXT,
  id_manutentor TEXT,
  data_criacao TIMESTAMP DEFAULT NOW(),
  data_fechamento TIMESTAMP,
  descricao_final TEXT,
  assinatura_manutentor TEXT,
  assinatura_operador TEXT,
  foto_evidencia TEXT,
  foto_inicial TEXT, -- Nova coluna adicionada para foto inicial da OS
  data_confirmacao TIMESTAMP,
  data_pendencia TIMESTAMP,
  data_liberacao TIMESTAMP
);

-- Tabela de Apontamentos (relacionada a ordens_servico)
CREATE TABLE IF NOT EXISTS apontamentos (
  id SERIAL PRIMARY KEY,
  os_id TEXT NOT NULL REFERENCES ordens_servico(id) ON DELETE CASCADE,
  tipo TEXT NOT NULL,
  motivo TEXT,
  timestamp TIMESTAMP DEFAULT NOW()
);

-- Tabela de Peças por Ordem de Serviço (relacionada a ordens_servico e pecas)
CREATE TABLE IF NOT EXISTS os_pecas (
  id SERIAL PRIMARY KEY,
  os_id TEXT NOT NULL REFERENCES ordens_servico(id) ON DELETE CASCADE,
  peca_id TEXT NOT NULL,
  quantidade INTEGER NOT NULL
);

-- Tabela de Agenda Preventiva
CREATE TABLE IF NOT EXISTS agenda_preventiva (
  id TEXT PRIMARY KEY,
  id_maquina TEXT,
  nome_maquina TEXT,
  id_usuario TEXT,
  nome_usuario TEXT,
  data_programada DATE,
  tipo_manutencao TEXT,
  status TEXT DEFAULT 'pendente',
  data_conclusao TIMESTAMP,
  laudo_dados TEXT, -- Nova coluna adicionada para dados do laudo do checklist
  laudo_pdf TEXT,    -- Nova coluna adicionada para o PDF do laudo do checklist
  data_cadastro TIMESTAMP DEFAULT NOW()
);

-- Tabela de Manuais (Nova tabela adicionada para manuais na nuvem)
CREATE TABLE IF NOT EXISTS manuais (
  id TEXT PRIMARY KEY,
  id_maquina TEXT NOT NULL,
  nome_maquina TEXT,
  nome_arquivo TEXT NOT NULL,
  arquivo_pdf TEXT NOT NULL,
  tamanho_mb NUMERIC(10,2),
  data_upload TIMESTAMP DEFAULT NOW(),
  UNIQUE(id_maquina, nome_arquivo)
);

-- Tabela de Registros de Tempo de Trabalho (Nova tabela para cronometragem detalhada)
CREATE TABLE IF NOT EXISTS registros_tempo_trabalho (
  id SERIAL PRIMARY KEY,
  id_manutentor TEXT NOT NULL,
  nome_manutentor TEXT,
  data_registro DATE NOT NULL,
  hora_inicio TIME,
  hora_fim TIME,
  duracao_minutos INTEGER DEFAULT 0,
  tipo_registro TEXT DEFAULT 'trabalho', -- 'trabalho', 'pausa'
  motivo_pausa TEXT,
  timestamp TIMESTAMP DEFAULT NOW()
);

-- Tabela de Sessões de Trabalho (Nova tabela para resumo diário de produtividade)
CREATE TABLE IF NOT EXISTS sessoes_trabalho (
  id SERIAL PRIMARY KEY,
  id_manutentor TEXT NOT NULL,
  nome_manutentor TEXT,
  data_sessao DATE NOT NULL,
  hora_inicio TIMESTAMP,
  hora_fim TIMESTAMP,
  pausas TEXT, -- JSON string com detalhes das pausas
  total_minutos_trabalhados INTEGER DEFAULT 0,
  total_minutos_pausa INTEGER DEFAULT 0,
  timestamp_criacao TIMESTAMP DEFAULT NOW()
);

-- Inserir usuário PCM padrão se não existir (Este comando é executado pelo initDB no Node.js)
-- Não precisa ser executado manualmente aqui, mas é importante para o funcionamento inicial.
-- Exemplo de inserção (a senha deve ser um hash bcrypt):
-- INSERT INTO usuarios (id, nome, email, senha, role)
-- VALUES ('PCM_ADMIN', 'Administrador PCM', 'pcm@admin.com', 'SENHA_HASH_AQUI', 'pcm');
```

## 4. Instruções de Atualização do Banco de Dados

Para garantir que todas as novas tabelas e colunas sejam criadas no seu banco de dados Neon, você tem duas opções:

### 4.1. Método Automático (Recomendado)

Após fazer o deploy dos novos arquivos na Vercel, acesse o link do seu sistema adicionando `/api/init-db` ao final da URL.

*   **Exemplo**: `https://ecomaintain.vercel.app/api/init-db`

Este endpoint executará o script `api/init-db.js` que contém todos os comandos `CREATE TABLE IF NOT EXISTS` e `ALTER TABLE ADD COLUMN IF NOT EXISTS`, garantindo que as tabelas e colunas sejam criadas sem afetar os dados existentes.

### 4.2. Método Manual (Via Console do Neon)

Se preferir, você pode acessar o painel do Neon, ir na aba **SQL Editor** e executar o script SQL completo fornecido na Seção 3 deste documento. Alternativamente, se as tabelas base já existirem, você pode executar apenas os comandos `ALTER TABLE` e `CREATE TABLE` para as novas estruturas:

```sql
-- Adicionar coluna foto_inicial à tabela ordens_servico
ALTER TABLE ordens_servico ADD COLUMN IF NOT EXISTS foto_inicial TEXT;

-- Adicionar colunas laudo_dados e laudo_pdf à tabela agenda_preventiva
ALTER TABLE agenda_preventiva ADD COLUMN IF NOT EXISTS laudo_dados TEXT;
ALTER TABLE agenda_preventiva ADD COLUMN IF NOT EXISTS laudo_pdf TEXT;

-- Criar a nova tabela para Manuais na Nuvem
CREATE TABLE IF NOT EXISTS manuais (
  id TEXT PRIMARY KEY,
  id_maquina TEXT NOT NULL,
  nome_maquina TEXT,
  nome_arquivo TEXT NOT NULL,
  arquivo_pdf TEXT NOT NULL,
  tamanho_mb NUMERIC(10,2),
  data_upload TIMESTAMP DEFAULT NOW(),
  UNIQUE(id_maquina, nome_arquivo)
);

-- Criar a nova tabela para Registros de Tempo de Trabalho
CREATE TABLE IF NOT EXISTS registros_tempo_trabalho (
  id SERIAL PRIMARY KEY,
  id_manutentor TEXT NOT NULL,
  nome_manutentor TEXT,
  data_registro DATE NOT NULL,
  hora_inicio TIME,
  hora_fim TIME,
  duracao_minutos INTEGER DEFAULT 0,
  tipo_registro TEXT DEFAULT 'trabalho',
  motivo_pausa TEXT,
  timestamp TIMESTAMP DEFAULT NOW()
);

-- Criar a nova tabela para Sessões de Trabalho
CREATE TABLE IF NOT EXISTS sessoes_trabalho (
  id SERIAL PRIMARY KEY,
  id_manutentor TEXT NOT NULL,
  nome_manutentor TEXT,
  data_sessao DATE NOT NULL,
  hora_inicio TIMESTAMP,
  hora_fim TIMESTAMP,
  pausas TEXT,
  total_minutos_trabalhados INTEGER DEFAULT 0,
  total_minutos_pausa INTEGER DEFAULT 0,
  timestamp_criacao TIMESTAMP DEFAULT NOW()
);
```

## 5. Instruções de Deploy

1.  **Baixe o arquivo ZIP** fornecido com a versão final do sistema.
2.  **Faça o deploy** dos arquivos na sua plataforma Vercel, substituindo os arquivos existentes.
3.  **Atualize o Banco de Dados** utilizando um dos métodos descritos na Seção 4.
4.  **Verifique as Variáveis de Ambiente**: Certifique-se de que a variável `DATABASE_URL` no seu projeto Vercel esteja corretamente configurada para o seu banco Neon. Nenhuma nova variável de ambiente é necessária.

## 6. Conclusão

O sistema EcoMaintain agora oferece um conjunto completo de ferramentas para a gestão eficiente da manutenção, desde o controle operacional no chão de fábrica até a análise estratégica no PCM. As funcionalidades implementadas visam otimizar processos, reduzir custos, aumentar a produtividade e fornecer insights valiosos para a tomada de decisões. Este é um passo significativo para a digitalização e modernização da sua gestão de manutenção.
