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

	LOD_INS = "Problem while loading instructions",
	INV_ARG_SRT = "Invalid Arguments. String expected.",
	EMP_INST = "Empty instructions file.",
	INV_INST = "Invalid or non-existent instructions file.",
	INV_DATA = "Invalid or non-existent data file.",
	
}

return {

	messages = messages,
}