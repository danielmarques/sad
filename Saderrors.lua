--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/23/2014
File: Saderros.lua
Title: sad errors
Description: Module that defines the error messages.

################################################################################
--]]

local messages = {

	MISS_DATA = "Missing data path.",
	MISS_STRA = "Missing strategy.",
	LOD_INS = "Problem while loading instructions.",
	LOD_DATA = "Problem while loading data.",
	EXEC_STRAT = "Problem while executing the prediction strategy.",
	CALC_STAT = "Problem while calculating the statistics.",
	SAVE_RES = "Problem while saving results into the file.",
	INV_ARG_SRT = "Invalid Arguments. String expected.",
	INV_ARG_TAB = "Invalid Arguments. Table expected.",
	EMP_INST = "Empty instructions file.",
	INV_INST = "Invalid or non-existent instructions file.",
	INV_DATA = "Invalid or non-existent data file.",
	INV_DATA_FOR = "Invalid data format. Correct format: data = {{real = <value 1>}, {real = <value 2>}, ... }",
	INV_DATA_FOR_STAT = "Invalid data format. Correct format: data = {{real = <value 1>, predicted = <value 2>}, {real = <value 3>, predicted = <value 4>}, ... }",
	INV_DATA_FOR_STAT_NUM = "Invalid data format. Correct format: data = {{real = <Number 1>, predicted = <number 2>}, {real = <number 3>, predicted = <number 4>}, ... }",
	INV_ARG_MEAN = "Invalid argument for a mean operation. Number expected.",

}

return {

	messages = messages,
}