--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Data: 17/07/2014
Arquivo: Dataentry.lua
Título: Dataentry
Descrição: Módulo de entrada de dados do sistema.

################################################################################
--]]

-- Carrega as instruções referentes aos experiments que serão executados.
-- experiments: arquivo de instruções fornecido pelo usuário
local function LoadExperiments ( experiments )

	-- Tabela onde serão armazenadas as instruções do arquivo
	local loadedExperiments = {}

	-- Definição da função Entry para armazenar as instruções na tabela loadedExperiments.
	-- Cada posição da tebela representa um experimento. Cada experimentos tem diversas tags.
	function Entry (experiment) loadedExperiments[#loadedExperiments+1] = experiment end

	-- Executa a função Entry multiplas vezes no arquivo "experiments", passado como parâmetro.
	dofile(experiments)

	return loadedExperiments

end

-- Carrega os dados que seo utilizados nos experimentos
-- dataset: arquivo de dados que foi definido no experimento (arquivo de instruções)
local function LoadData( dataset )

	local data = {}

	function Entry (instance)
		y = {}
		y.real = instance[1]
		data[#data+1] = y
	end

	dofile(dataset)

	return data

end

-- Retorna a tabela com os componentes do modulo Dataentry
return {

	LoadExperiments = LoadExperiments,
	LoadData = LoadData,
}