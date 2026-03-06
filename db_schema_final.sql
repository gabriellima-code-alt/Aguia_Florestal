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
