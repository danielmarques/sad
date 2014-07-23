--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/17/2014
File: Dataentry.lua
Title: Dataentry
Description: Module responseble for the data entry.

################################################################################
--]]

local Saderrors = require "Saderrors"

-- Loads the instructions file, that contains the description of the experiments.
-- experiments: string with the path to the instructions file.
local function LoadExperiments ( experiments )

	if type(experiments) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	-- Table into where the instructions will be loaded
	local loadedExperiments = {}

	-- Definition of the Entry function that is used ins the instructiuons file.
	-- Each position of the table represents one experiment. Each experiment may have several tags.
	function Entry (experiment) loadedExperiments[#loadedExperiments+1] = experiment end

	-- Loads the instruction file into the loadedExperiments table

	local ok, ret = pcall(loadfile, experiments)

	if ok then

		if ret ~= nil then ret() else error(Saderrors.messages["INV_INST"]) end

	else

		error(ret)

	end

	return loadedExperiments

end

-- Loads the data file to be used in an experiment
-- dataset: data file defined to that experiment
local function LoadData( dataset )

	if type(dataset) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	-- Table into where the data willbe loaded
	local data = {}

	-- Definition of the Entry function that is used in the data file
	-- The data file contains only one colum with the real values for each instance
	function Entry (instance)
		y = {}
		y.real = instance[1]
		data[#data+1] = y
	end

	-- Loads the instruction file into the loadedExperiments table

	local ok, ret = pcall(loadfile, dataset)

	if ok then

		if ret ~= nil then ret() else error (Saderrors.messages["INV_DATA"]) end

	else

		error(ret)

	end

	return data

end

-- Retorna a tabela com os componentes do modulo Dataentry
return {

	LoadExperiments = LoadExperiments,
	LoadData = LoadData,
}