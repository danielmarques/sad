--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/28/2014
File: Statistics.lua
Title: Statistics
Description: Module responsable for the calculaion of statistics.

################################################################################
--]]

local Saderrors = require "Saderrors"

-- Function that counts the number of correct and incorrect instances
-- data: Must be an table of the form: data = {key1 = {real = <value x>, predicted = <value y>}, ...}
function Correctness( data )

	if type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	local correct, incorrect = 0, 0

	for k, v in pairs(data) do

		if type(v) == "table" and v.real ~= nil and v.predicted ~=nil then

			if v.real == v.predicted then correct = correct + 1 else incorrect = incorrect + 1 end

		else error(Saderrors.messages["INV_DATA_FOR_STAT"]) end

	end

	return correct, incorrect

end

-- Function that calculates the mean absolute error for the group of all instances in data
-- data: Must be an table of the form: data = {key1 = {real = <number x>, predicted = <number y>}, ...}
function MeanAbsError( data )

	if type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	local sum, count = 0, 0

	for k, v in pairs(data) do

		if type(v) == "table" and v.real ~= nil and type(v.real) == "number" and v.predicted ~=nil and type(v.predicted) == "number" then

			sum = sum + math.abs(v.predicted - v.real)
			count = count + 1

		else error(Saderrors.messages["INV_DATA_FOR_STAT_NUM"]) end

	end

	if count > 0 then return sum / count else return 0 end

end

-- Function that calculates the root mean squared error for the group of all instances in data
-- data: Must be an table of the form: data = {key1 = {real = <number x>, predicted = <number y>}, ...}
function RootMeanSqrtError( data )

	if type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	local sum, count = 0, 0

	for k, v in pairs(data) do

		if type(v) == "table" and v.real ~= nil and type(v.real) == "number" and v.predicted ~=nil and type(v.predicted) == "number" then

			sum = sum + (v.predicted - v.real)^2
			count = count + 1

		else error(Saderrors.messages["INV_DATA_FOR_STAT_NUM"]) end

	end

	if count > 0 then return math.sqrt(sum / count) else return 0 end

end

-- Returns the table with the module elements
return {

	Correctness = Correctness,
	MeanAbsError = MeanAbsError,
	RootMeanSqrtError = RootMeanSqrtError,

}
