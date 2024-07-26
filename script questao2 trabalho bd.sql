-- MySQL Script generated by MySQL Workbench
-- Sun Jun 16 09:49:38 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `trabalhobd` DEFAULT CHARACTER SET utf8 ;
USE `trabalhobd` ;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`endereco` (
  `id` INT NOT NULL auto_increment,
  `pais` VARCHAR(255) NOT NULL,
  `estado` VARCHAR(255) NOT NULL,
  `cidade` VARCHAR(255) NOT NULL,
  `bairro` VARCHAR(255) NOT NULL,	
  `cep` char(9) NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(255) NULL,
	PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`pessoa` (
  `id` INT NOT NULL auto_increment,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uk_cpf` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`paciente` (
  `id` INT NOT NULL auto_increment,
  `dt_nascimento` TIMESTAMP NOT NULL,
  `endereco_id` INT NOT NULL,
  `pessoa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_paciente_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `trabalhobd`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paciente_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `trabalhobd`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`posto_saude` (
  `id` INT NOT NULL auto_increment,
  `nome` VARCHAR(255) NULL,
  `telefone` VARCHAR(20) NULL,
  `email` VARCHAR(255) NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_posto_saude_endereco`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `trabalhobd`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`profissional_saude` (
  `id` INT NOT NULL auto_increment,
  `cargo` VARCHAR(45) NOT NULL,
  `pessoa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_profissional_saude_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `trabalhobd`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`vacina` (
  `id` INT NOT NULL auto_increment,
  `nome` VARCHAR(255) NULL,
  `fabricante` VARCHAR(255) NULL,
  `numero_doses_recomendadas` INT NULL,
  `dias_intervalo_doses` INT NULL,
  `observacao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`lote_vacina` (
  `id` INT NOT NULL auto_increment,
  `vacina_id` INT NOT NULL,
  `numero` INT NOT NULL,
  `dt_fabricacao` TIMESTAMP NOT NULL,
  `dt_validade` TIMESTAMP NOT NULL,
  `qtde_recebida` INT NOT NULL,
  `qtde_disponivel` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_lote_vacina_vacina`
    FOREIGN KEY (`vacina_id`)
    REFERENCES `trabalhobd`.`vacina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `trabalhobd`.`vacinacao` (
  `id` INT NOT NULL auto_increment,
  `lote_vacina_id` INT NOT NULL,
  `paciente_id` INT NOT NULL,
  `profissional_saude_id` INT NOT NULL,
  `posto_saude_id` INT NOT NULL,
  `dt_vacinacao` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_vacinacao_lote_vacina`
    FOREIGN KEY (`lote_vacina_id`)
    REFERENCES `trabalhobd`.`lote_vacina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_paciente`
    FOREIGN KEY (`paciente_id`)
    REFERENCES `trabalhobd`.`paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_profissional_saude`
    FOREIGN KEY (`profissional_saude_id`)
    REFERENCES `trabalhobd`.`profissional_saude` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacinacao_posto_saude`
    FOREIGN KEY (`posto_saude_id`)
    REFERENCES `trabalhobd`.`posto_saude` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
