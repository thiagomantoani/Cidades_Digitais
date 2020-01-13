-- MySQL Script generated by MySQL Workbench
-- 01/13/20 15:07:12
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cidades_digitais_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cidades_digitais_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cidades_digitais_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `cidades_digitais_db` ;

-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`municipio` (
  `cod_ibge` INT(7) NOT NULL,
  `nome_municipio` VARCHAR(50) NULL,
  `populacao` INT NULL,
  `uf` VARCHAR(2) NULL,
  `regiao` VARCHAR(15) NULL,
  `cnpj` VARCHAR(14) NULL,
  `dist_capital` INT NULL,
  `endereco` VARCHAR(45) NULL,
  `numero` VARCHAR(10) NULL,
  `complemento` VARCHAR(250) NULL,
  `bairro` VARCHAR(45) NULL,
  `idhm` FLOAT NULL,
  `latitude` DECIMAL(10,8) NULL,
  `longitude` DECIMAL(10,8) NULL,
  PRIMARY KEY (`cod_ibge`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`entidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`entidade` (
  `cnpj` CHAR(14) NOT NULL,
  `nome` VARCHAR(50) NULL,
  `endereco` VARCHAR(100) NULL,
  `numero` VARCHAR(10) NULL,
  `bairro` VARCHAR(100) NULL,
  `cep` VARCHAR(8) NULL,
  `nome_municipio` VARCHAR(50) NULL,
  `uf` VARCHAR(2) NULL,
  `observacao` VARCHAR(1000) NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`lote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`lote` (
  `cod_lote` INT NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `contrato` VARCHAR(10) NULL,
  `dt_inicio_vig` DATE NULL,
  `dt_final_vig` DATE NULL,
  `dt_reajuste` DATE NULL,
  PRIMARY KEY (`cod_lote`),
  INDEX `fk_lote_entidade1_idx` (`cnpj` ASC),
  CONSTRAINT `fk_lote_entidade1`
    FOREIGN KEY (`cnpj`)
    REFERENCES `cidades_digitais_db`.`entidade` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`cd` (
  `cod_ibge` INT(7) NOT NULL,
  `cod_lote` INT NOT NULL,
  `os_pe` VARCHAR(10) NULL,
  `data_pe` DATE NULL,
  `os_imp` VARCHAR(10) NULL,
  `data_imp` DATE NULL,
  INDEX `fk_cd_lote1_idx` (`cod_lote` ASC),
  PRIMARY KEY (`cod_ibge`),
  CONSTRAINT `fk_cd_lote1`
    FOREIGN KEY (`cod_lote`)
    REFERENCES `cidades_digitais_db`.`lote` (`cod_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cd_municipio1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`municipio` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`contato` (
  `cod_contato` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(14) NULL,
  `cod_ibge` INT(7) NULL,
  `nome` VARCHAR(50) NULL,
  `email` VARCHAR(100) NULL,
  `funcao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_contato`),
  INDEX `fk_contato_entidade1_idx` (`cnpj` ASC),
  INDEX `fk_contato_cd1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_contato_entidade1`
    FOREIGN KEY (`cnpj`)
    REFERENCES `cidades_digitais_db`.`entidade` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contato_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`telefone` (
  `cod_telefone` INT NOT NULL AUTO_INCREMENT,
  `cod_contato` INT NOT NULL,
  `telefone` VARCHAR(11) NULL,
  `tipo` VARCHAR(10) NULL,
  PRIMARY KEY (`cod_telefone`),
  INDEX `fk_telefone_contato1_idx` (`cod_contato` ASC),
  CONSTRAINT `fk_telefone_contato1`
    FOREIGN KEY (`cod_contato`)
    REFERENCES `cidades_digitais_db`.`contato` (`cod_contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`natureza_despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`natureza_despesa` (
  `cod_natureza_despesa` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_natureza_despesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`classe_empenho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`classe_empenho` (
  `cod_classe_empenho` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_classe_empenho`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`tipo_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`tipo_item` (
  `cod_tipo_item` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_tipo_item`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`itens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`itens` (
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `cod_natureza_despesa` INT NOT NULL,
  `cod_classe_empenho` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `unidade` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_classificacao_itens1_idx` (`cod_natureza_despesa` ASC),
  INDEX `fk_itens_subitem1_idx` (`cod_classe_empenho` ASC),
  INDEX `fk_itens_tipo_item1_idx` (`cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_classificacao_itens1`
    FOREIGN KEY (`cod_natureza_despesa`)
    REFERENCES `cidades_digitais_db`.`natureza_despesa` (`cod_natureza_despesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_subitem1`
    FOREIGN KEY (`cod_classe_empenho`)
    REFERENCES `cidades_digitais_db`.`classe_empenho` (`cod_classe_empenho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_tipo_item1`
    FOREIGN KEY (`cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`tipo_item` (`cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`usuario` (
  `cod_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(45) NULL,
  `status` CHAR(1) NULL,
  `login` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`modulo` (
  `cod_modulo` INT NOT NULL,
  `categoria_1` VARCHAR(45) NULL,
  `categoria_2` VARCHAR(45) NULL,
  `categoria_3` VARCHAR(45) NULL,
  `descricao` VARCHAR(200) NULL,
  PRIMARY KEY (`cod_modulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`categoria` (
  `cod_categoria` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`pid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`pid` (
  `cod_pid` INT NOT NULL AUTO_INCREMENT,
  `cod_ibge` INT(7) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `inep` VARCHAR(15) NULL,
  PRIMARY KEY (`cod_pid`),
  INDEX `fk_pid_municipio1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_pid_municipio1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`municipio` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`ponto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`ponto` (
  `cod_ponto` INT NOT NULL,
  `cod_categoria` INT NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  `cod_pid` INT NOT NULL,
  `endereco` VARCHAR(255) NULL,
  `numero` VARCHAR(45) NULL,
  `complemento` VARCHAR(1000) NULL,
  `bairro` VARCHAR(100) NULL,
  `cep` CHAR(8) NULL,
  `latitude` DECIMAL(10,8) NULL,
  `longitude` DECIMAL(10,8) NULL,
  PRIMARY KEY (`cod_ponto`, `cod_categoria`, `cod_ibge`),
  INDEX `fk_ponto_categoria1_idx` (`cod_categoria` ASC),
  INDEX `fk_ponto_cd1_idx` (`cod_ibge` ASC),
  INDEX `fk_ponto_pid1_idx` (`cod_pid` ASC),
  CONSTRAINT `fk_ponto_categoria1`
    FOREIGN KEY (`cod_categoria`)
    REFERENCES `cidades_digitais_db`.`categoria` (`cod_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ponto_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ponto_pid1`
    FOREIGN KEY (`cod_pid`)
    REFERENCES `cidades_digitais_db`.`pid` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`cd_itens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`cd_itens` (
  `cod_ibge` INT(7) NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `quantidade_previsto` INT NULL,
  `quantidade_projeto_executivo` INT NULL,
  `quantidade_termo_instalacao` INT NULL,
  PRIMARY KEY (`cod_ibge`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_has_cd_cd1_idx` (`cod_ibge` ASC),
  INDEX `fk_cd_itens_itens2_idx` (`cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_has_cd_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cd_itens_itens2`
    FOREIGN KEY (`cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens` (`cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`ponto_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`ponto_has_usuario` (
  `ponto_cod_ponto` INT NOT NULL,
  `ponto_categoria_cod_categoria` INT NOT NULL,
  `usuario_cod_usuario` INT NOT NULL,
  `usuario_perfil_cod_perfil` INT NOT NULL,
  PRIMARY KEY (`ponto_cod_ponto`, `ponto_categoria_cod_categoria`, `usuario_cod_usuario`, `usuario_perfil_cod_perfil`),
  INDEX `fk_ponto_has_usuario_usuario1_idx` (`usuario_cod_usuario` ASC, `usuario_perfil_cod_perfil` ASC),
  CONSTRAINT `fk_ponto_has_usuario_usuario1`
    FOREIGN KEY (`usuario_cod_usuario`)
    REFERENCES `cidades_digitais_db`.`usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`previsao_empenho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`previsao_empenho` (
  `cod_previsao_empenho` INT NOT NULL AUTO_INCREMENT,
  `cod_lote` INT NOT NULL,
  `cod_natureza_despesa` INT NOT NULL,
  `data` DATE NULL,
  `tipo` CHAR(1) NULL,
  `ano_referencia` INT NULL,
  PRIMARY KEY (`cod_previsao_empenho`),
  INDEX `fk_empenho_lote1_idx` (`cod_lote` ASC),
  INDEX `fk_previsao_empenho_natureza_despesa1_idx` (`cod_natureza_despesa` ASC),
  CONSTRAINT `fk_empenho_lote10`
    FOREIGN KEY (`cod_lote`)
    REFERENCES `cidades_digitais_db`.`lote` (`cod_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_previsao_empenho_natureza_despesa1`
    FOREIGN KEY (`cod_natureza_despesa`)
    REFERENCES `cidades_digitais_db`.`natureza_despesa` (`cod_natureza_despesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`empenho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`empenho` (
  `cod_empenho` VARCHAR(13) NOT NULL,
  `cod_previsao_empenho` INT NOT NULL,
  `data` DATETIME NULL,
  `contador` INT NULL,
  PRIMARY KEY (`cod_empenho`),
  INDEX `fk_empenho_previsao_empenho1_idx` (`cod_previsao_empenho` ASC),
  CONSTRAINT `fk_empenho_previsao_empenho1`
    FOREIGN KEY (`cod_previsao_empenho`)
    REFERENCES `cidades_digitais_db`.`previsao_empenho` (`cod_previsao_empenho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`lote_itens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`lote_itens` (
  `cod_lote` INT NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `preco` DECIMAL(12,2) NULL DEFAULT 0,
  PRIMARY KEY (`cod_lote`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_lote_has_itens_lote1_idx` (`cod_lote` ASC),
  INDEX `fk_lote_itens_itens1_idx` (`cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_lote_has_itens_lote1`
    FOREIGN KEY (`cod_lote`)
    REFERENCES `cidades_digitais_db`.`lote` (`cod_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lote_itens_itens1`
    FOREIGN KEY (`cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens` (`cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`itens_previsao_empenho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`itens_previsao_empenho` (
  `cod_previsao_empenho` INT NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `cod_lote` INT NOT NULL,
  `valor` DECIMAL(12,2) NULL DEFAULT 0,
  `quantidade` INT NULL DEFAULT 0,
  PRIMARY KEY (`cod_previsao_empenho`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_previsao_empenho_previsao_empenho1_idx` (`cod_previsao_empenho` ASC),
  INDEX `fk_itens_previsao_empenho_lote_itens1_idx` (`cod_lote` ASC, `cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_previsao_empenho_previsao_empenho1`
    FOREIGN KEY (`cod_previsao_empenho`)
    REFERENCES `cidades_digitais_db`.`previsao_empenho` (`cod_previsao_empenho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_previsao_empenho_lote_itens1`
    FOREIGN KEY (`cod_lote` , `cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`lote_itens` (`cod_lote` , `cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`itens_empenho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`itens_empenho` (
  `cod_empenho` VARCHAR(13) NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `cod_previsao_empenho` INT NOT NULL,
  `valor` DECIMAL(12,2) NULL DEFAULT 0,
  `quantidade` INT NULL DEFAULT 0,
  PRIMARY KEY (`cod_empenho`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_empenho_empenho1_idx` (`cod_empenho` ASC),
  INDEX `fk_itens_empenho_itens_previsao_empenho1_idx` (`cod_previsao_empenho` ASC, `cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_empenho_empenho1`
    FOREIGN KEY (`cod_empenho`)
    REFERENCES `cidades_digitais_db`.`empenho` (`cod_empenho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_empenho_itens_previsao_empenho1`
    FOREIGN KEY (`cod_previsao_empenho` , `cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens_previsao_empenho` (`cod_previsao_empenho` , `cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`fatura` (
  `num_nf` INT NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  `dt_nf` DATE NULL,
  PRIMARY KEY (`num_nf`, `cod_ibge`),
  INDEX `fk_Fatura_cd1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_Fatura_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`reajuste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`reajuste` (
  `ano_ref` INT NOT NULL,
  `cod_lote` INT NOT NULL,
  `percentual` FLOAT NULL,
  PRIMARY KEY (`ano_ref`, `cod_lote`),
  INDEX `fk_reajuste_lote1_idx` (`cod_lote` ASC),
  CONSTRAINT `fk_reajuste_lote1`
    FOREIGN KEY (`cod_lote`)
    REFERENCES `cidades_digitais_db`.`lote` (`cod_lote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`etapa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`etapa` (
  `cod_etapa` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `duracao` INT NULL,
  `depende` INT NULL,
  `delay` INT NULL,
  `setor_resp` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_etapa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`etapas_cd`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`etapas_cd` (
  `cod_ibge` INT(7) NOT NULL,
  `cod_etapa` INT NOT NULL,
  `dt_inicio` DATETIME NULL,
  `dt_fim` DATETIME NULL,
  `responsavel` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_ibge`, `cod_etapa`),
  INDEX `fk_etapas_cd_etapa1_idx` (`cod_etapa` ASC),
  CONSTRAINT `fk_etapas_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etapas_cd_etapa1`
    FOREIGN KEY (`cod_etapa`)
    REFERENCES `cidades_digitais_db`.`etapa` (`cod_etapa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`prefeitos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`prefeitos` (
  `cod_prefeito` INT NOT NULL AUTO_INCREMENT,
  `cod_ibge` INT(7) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(11) NULL,
  `rg` VARCHAR(20) NULL,
  `partido` VARCHAR(45) NULL,
  `exercicio` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_prefeito`),
  INDEX `fk_prefeitos_municipio1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_prefeitos_municipio1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`municipio` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`processo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`processo` (
  `cod_processo` CHAR(17) NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_processo`, `cod_ibge`),
  INDEX `fk_processo_cd1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_processo_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`cd_itens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`cd_itens` (
  `cod_ibge` INT(7) NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `quantidade_previsto` INT NULL,
  `quantidade_projeto_executivo` INT NULL,
  `quantidade_termo_instalacao` INT NULL,
  PRIMARY KEY (`cod_ibge`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_has_cd_cd1_idx` (`cod_ibge` ASC),
  INDEX `fk_cd_itens_itens2_idx` (`cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_has_cd_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cd_itens_itens2`
    FOREIGN KEY (`cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens` (`cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`tipologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`tipologia` (
  `cod_tipologia` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_tipologia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`otb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`otb` (
  `cod_otb` INT NOT NULL,
  `dt_pgto` DATE NULL,
  PRIMARY KEY (`cod_otb`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`uacom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`uacom` (
  `cod_ibge` INT(7) NOT NULL,
  `data` DATETIME NOT NULL,
  `titulo` VARCHAR(45) NULL,
  `relato` TEXT NULL,
  PRIMARY KEY (`cod_ibge`, `data`),
  INDEX `fk_uacom_cd1_idx` (`cod_ibge` ASC),
  CONSTRAINT `fk_uacom_cd1`
    FOREIGN KEY (`cod_ibge`)
    REFERENCES `cidades_digitais_db`.`cd` (`cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`assunto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`assunto` (
  `cod_assunto` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_assunto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`uacom_assunto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`uacom_assunto` (
  `cod_ibge` INT(7) NOT NULL,
  `data` DATETIME NOT NULL,
  `cod_assunto` INT NOT NULL,
  PRIMARY KEY (`cod_ibge`, `data`, `cod_assunto`),
  INDEX `fk_uacom_has_assunto_assunto1_idx` (`cod_assunto` ASC),
  INDEX `fk_uacom_has_assunto_uacom1_idx` (`cod_ibge` ASC, `data` ASC),
  CONSTRAINT `fk_uacom_has_assunto_uacom1`
    FOREIGN KEY (`cod_ibge` , `data`)
    REFERENCES `cidades_digitais_db`.`uacom` (`cod_ibge` , `data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uacom_has_assunto_assunto1`
    FOREIGN KEY (`cod_assunto`)
    REFERENCES `cidades_digitais_db`.`assunto` (`cod_assunto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`pid_tipologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`pid_tipologia` (
  `cod_pid` INT NOT NULL,
  `cod_tipologia` INT NOT NULL,
  PRIMARY KEY (`cod_pid`, `cod_tipologia`),
  INDEX `fk_ponto_has_tipologia_tipologia1_idx` (`cod_tipologia` ASC),
  INDEX `fk_ponto_tipologia_pid1_idx` (`cod_pid` ASC),
  CONSTRAINT `fk_ponto_has_tipologia_tipologia1`
    FOREIGN KEY (`cod_tipologia`)
    REFERENCES `cidades_digitais_db`.`tipologia` (`cod_tipologia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ponto_tipologia_pid1`
    FOREIGN KEY (`cod_pid`)
    REFERENCES `cidades_digitais_db`.`pid` (`cod_pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`itens_fatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`itens_fatura` (
  `num_nf` INT NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  `cod_empenho` VARCHAR(13) NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `valor` DECIMAL(12,2) NULL DEFAULT 0,
  `quantidade` INT NULL DEFAULT 0,
  PRIMARY KEY (`num_nf`, `cod_ibge`, `cod_empenho`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_fatura_itens_empenho1_idx` (`cod_empenho` ASC, `cod_item` ASC, `cod_tipo_item` ASC),
  INDEX `fk_itens_fatura_fatura1_idx` (`num_nf` ASC, `cod_ibge` ASC),
  CONSTRAINT `fk_itens_fatura_itens_empenho1`
    FOREIGN KEY (`cod_empenho` , `cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens_empenho` (`cod_empenho` , `cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_fatura_fatura1`
    FOREIGN KEY (`num_nf` , `cod_ibge`)
    REFERENCES `cidades_digitais_db`.`fatura` (`num_nf` , `cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`fatura_otb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`fatura_otb` (
  `cod_otb` INT NOT NULL,
  `num_nf` INT NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  PRIMARY KEY (`cod_otb`, `num_nf`, `cod_ibge`),
  INDEX `fk_Fatura_has_otb_otb1_idx` (`cod_otb` ASC),
  INDEX `fk_fatura_otb_fatura1_idx` (`num_nf` ASC, `cod_ibge` ASC),
  CONSTRAINT `fk_Fatura_has_otb_otb1`
    FOREIGN KEY (`cod_otb`)
    REFERENCES `cidades_digitais_db`.`otb` (`cod_otb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fatura_otb_fatura1`
    FOREIGN KEY (`num_nf` , `cod_ibge`)
    REFERENCES `cidades_digitais_db`.`fatura` (`num_nf` , `cod_ibge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`itens_otb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`itens_otb` (
  `cod_otb` INT NOT NULL,
  `num_nf` INT NOT NULL,
  `cod_ibge` INT(7) NOT NULL,
  `cod_empenho` VARCHAR(13) NOT NULL,
  `cod_item` INT NOT NULL,
  `cod_tipo_item` INT NOT NULL,
  `valor` DECIMAL(12,2) NULL DEFAULT 0,
  `quantidade` INT NULL DEFAULT 0,
  PRIMARY KEY (`cod_otb`, `num_nf`, `cod_ibge`, `cod_empenho`, `cod_item`, `cod_tipo_item`),
  INDEX `fk_itens_fatura_has_otb_otb1_idx` (`cod_otb` ASC),
  INDEX `fk_itens_otb_itens_fatura1_idx` (`num_nf` ASC, `cod_ibge` ASC, `cod_empenho` ASC, `cod_item` ASC, `cod_tipo_item` ASC),
  CONSTRAINT `fk_itens_fatura_has_otb_otb1`
    FOREIGN KEY (`cod_otb`)
    REFERENCES `cidades_digitais_db`.`otb` (`cod_otb`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_otb_itens_fatura1`
    FOREIGN KEY (`num_nf` , `cod_ibge` , `cod_empenho` , `cod_item` , `cod_tipo_item`)
    REFERENCES `cidades_digitais_db`.`itens_fatura` (`num_nf` , `cod_ibge` , `cod_empenho` , `cod_item` , `cod_tipo_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`usuario_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`usuario_modulo` (
  `cod_usuario` INT NOT NULL,
  `cod_modulo` INT NOT NULL,
  PRIMARY KEY (`cod_usuario`, `cod_modulo`),
  INDEX `fk_usuario_has_modulo_modulo1_idx` (`cod_modulo` ASC),
  INDEX `fk_usuario_has_modulo_usuario1_idx` (`cod_usuario` ASC),
  CONSTRAINT `fk_usuario_has_modulo_usuario1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `cidades_digitais_db`.`usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_modulo_modulo1`
    FOREIGN KEY (`cod_modulo`)
    REFERENCES `cidades_digitais_db`.`modulo` (`cod_modulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidades_digitais_db`.`log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidades_digitais_db`.`log` (
  `cod_log` INT NOT NULL AUTO_INCREMENT,
  `cod_usuario` INT NOT NULL,
  `data` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nome_tabela` VARCHAR(45) NOT NULL,
  `operacao` CHAR(1) NOT NULL,
  `espelho` LONGTEXT NULL,
  `cod_int_1` INT NULL,
  `cod_int_2` INT NULL,
  `cod_int_3` INT NULL,
  `cod_int_4` INT NULL,
  `cod_int_5` INT NULL,
  `cod_data` DATETIME NULL,
  `cod_processo` CHAR(17) NULL,
  `cod_cnpj` CHAR(14) NULL,
  `cod_empenho` VARCHAR(13) NULL,
  PRIMARY KEY (`cod_log`, `cod_usuario`),
  INDEX `fk_log_usuario1_idx` (`cod_usuario` ASC),
  CONSTRAINT `fk_log_usuario1`
    FOREIGN KEY (`cod_usuario`)
    REFERENCES `cidades_digitais_db`.`usuario` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `cidades_digitais_db`;

DELIMITER $$
USE `cidades_digitais_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cidades_digitais_db`.`insere_lote_itens` AFTER INSERT ON `lote` FOR EACH ROW
BEGIN
insert into lote_itens(cod_lote, cod_item, cod_tipo_item) (select lote.cod_lote, itens.cod_item, itens.cod_tipo_item from lote, itens 
where lote.cod_lote = (select last_insert_id(new.cod_lote)));
END
$$

USE `cidades_digitais_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cidades_digitais_db`.`insere_cd_itens` AFTER INSERT ON `cd` FOR EACH ROW
BEGIN
insert into cd_itens (cod_ibge, cod_item, cod_tipo_item) (select cd.cod_ibge, itens.cod_item, itens.cod_tipo_item from cd, itens
where cd.cod_ibge = (select last_insert_id(new.cod_ibge)));
END
$$

USE `cidades_digitais_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cidades_digitais_db`.`insere_itens_previsao_empenho` AFTER INSERT ON `previsao_empenho` FOR EACH ROW
BEGIN
	insert into itens_previsao_empenho (cod_previsao_empenho, cod_item, cod_tipo_item, cod_lote)
	(select previsao_empenho.cod_previsao_empenho, lote_itens.cod_item, lote_itens.cod_tipo_item, lote_itens.cod_lote
    from previsao_empenho, lote_itens
    inner join itens on (lote_itens.cod_item = itens.cod_item and lote_itens.cod_tipo_item = itens.cod_tipo_item) 
    where previsao_empenho.cod_previsao_empenho = (select last_insert_id(new.cod_previsao_empenho)) and lote_itens.cod_lote = previsao_empenho.cod_lote and itens.cod_natureza_despesa = previsao_empenho.cod_natureza_despesa);
END
$$

USE `cidades_digitais_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cidades_digitais_db`.`insere_itens_empenho` AFTER INSERT ON `empenho` FOR EACH ROW
BEGIN
insert into itens_empenho (cod_empenho, cod_item, cod_tipo_item, cod_previsao_empenho, valor) 
(select empenho.cod_empenho, itens_previsao_empenho.cod_item, itens_previsao_empenho.cod_tipo_item, empenho.cod_previsao_empenho, itens_previsao_empenho.valor
from empenho
inner join previsao_empenho on (empenho.cod_previsao_empenho = previsao_empenho.cod_previsao_empenho)
inner join itens_previsao_empenho on (previsao_empenho.cod_previsao_empenho = itens_previsao_empenho.cod_previsao_empenho)
where empenho.cod_empenho = (select last_insert_id(new.cod_empenho)));
END
$$

USE `cidades_digitais_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cidades_digitais_db`.`insere_itens_otb` AFTER INSERT ON `fatura_otb` FOR EACH ROW
BEGIN
	insert into itens_otb (cod_otb, num_nf, cod_empenho, cod_item, cod_tipo_item,  valor, quantidade) 
    (select fatura_otb.cod_otb, fatura_otb.num_nf, itens_fatura.cod_empenho, itens_fatura.cod_item, itens_fatura.cod_tipo_item, itens_fatura.valor, itens_fatura.quantidade
    from fatura_otb
    inner join itens_fatura on (fatura_otb.num_nf = itens_fatura.num_nf)
    where itens_fatura.num_nf = (select last_insert_id(new.num_nf)) and fatura_otb.cod_otb = (select last_insert_id(new.cod_otb)));
END
$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;