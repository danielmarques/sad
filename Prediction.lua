--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/23/2014
File: Prediction.lua
Title: Prediction
Description: Module responsable for the predictions made by the strategies.

################################################################################
--]]

local Saderrors = require "Saderrors"

-- Strategy that repeats the value os the preavious instance
-- data: must be an array in the format {{real = <value 1>}, {real = <value 2>}, ... }
local function RepeatPrevious( data )
	
	if not IsArray(data) then error(Saderrors.messages["INV_DATA_FOR"]) end

	--Selects the previous value as the predicted value. The predicted value of the first instance is nil.
	for i = 1, #data-1, 1 do

		if (type(data[i]) == "table" and data[i].real ~= nil) then

			data[i+1].predicted = data[i].real

		else error (Saderrors.messages["INV_DATA_FOR"]) end

	end

	return data

end

-- Strategy that uses the mean of the value of all instances as the prediction
-- data: must be an table in the format {key1 = {real = <value 1>}, key2 = {real = <value 2>}, ... }
local function MeanAll( data )

	if type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	local sum, count = 0, 0

	for k, v in pairs(data) do

		if (type(v) == "table" and v.real ~= nil) then

			if type(v.real) == "number" then
			
				sum = sum + v.real
				count = count + 1

			else error (Saderrors.messages["INV_ARG_MEAN"]) end

		else error (Saderrors.messages["INV_DATA_FOR"]) end

	end

	local mean = sum / count

	for k, v in pairs(data) do

		data[k].predicted = mean

	end

	return data

end

-- Strategy that uses the mean of he value of the previous p instances as the prediction for the next instance
-- data: must be an array in the format {{real = <value 1>}, {real = <value 2>}, ... }
-- p: the number of previous instances to consider
local function MeanP( data, p )

	if not IsArray(data) then error(Saderrors.messages["INV_DATA_FOR"]) end

	local sum, previousSize = 0, 0
	local previousTale = 1

	for i = 1, #data-1, 1 do

		if (type(data[i]) == "table" and data[i].real ~= nil) then

			if type(data[i].real) == "number" then

				sum = sum + data[i].real
				previousSize = previousSize + 1
				data[i+1].predicted = sum / previousSize

				if previousSize == p then

					sum = sum - data[previousTale].real
					previousTale = previousTale + 1
					previousSize = previousSize - 1

				end

			else error (Saderrors.messages["INV_ARG_MEAN"]) end

		else error (Saderrors.messages["INV_DATA_FOR"]) end

	end

	return data

end

-- Strategy that uses the more numerous value among all instances as the prediction
-- data: must be an table in the format {key1 = {real = <value 1>}, key2 = {real = <value 2>}, ... }
local function MoreNumerousAll( data )

	if type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	local histogram = {}

	for k, v in pairs(data) do

		if (type(v) == "table" and v.real ~= nil) then

			if histogram[v.real] ~= nil then histogram[v.real] = histogram[v.real] + 1
			else histogram[v.real] = 1 end

		else error (Saderrors.messages["INV_DATA_FOR"]) end

	end

	local max_count, max = 0, nil

	for k, v in pairs(histogram) do
		
		if v > max_count then max = k; max_count = v end

	end

	for k, v in pairs(data) do

		data[k].predicted = max

	end

	return data

end

-- Strategy that uses the more numerous value among the previous p instances as the prediction for the next instance
-- data: must be an array in the format {{real = <value 1>}, {real = <value 2>}, ... }
-- p: the number of previous instances to consider
local function MoreNumerousP( data, p )

	if not IsArray(data) then error(Saderrors.messages["INV_DATA_FOR"]) end

	local previousTale, previousSize = 1, 0
	local previousHist = {}

	for i = 1, #data-1, 1 do

		if (type(data[i]) == "table" and data[i].real ~= nil) then

			if previousHist[data[i].real] then previousHist[data[i].real] = previousHist[data[i].real] + 1 
			else previousHist[data[i].real] = 1 end

			previousSize = previousSize + 1

			--verificar o mais numeroso no historico
			local max_count, max = 0, nil

			for k, v in pairs(previousHist) do
				
				if v > max_count then max = k; max_count = v end

			end

			data[i+1].predicted = max

			if previousSize == p then

				previousHist[data[previousTale].real] = previousHist[data[previousTale].real] - 1
				if previousHist[data[previousTale].real] == 0 then previousHist[data[previousTale].real] = nil end

				previousTale = previousTale + 1
				previousSize = previousSize - 1

			end

		else error (Saderrors.messages["INV_DATA_FOR"]) end

	end

	return data

end

-- Function that verifies if the table is an array, that is, has only sequential numeric keys
-- t: is any table
function IsArray( t )

    if type(t) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

    -- Check if all the table keys are numerical and count their number
    local count = 0
    for k,v in pairs(t) do

        if type(k) ~= "number" then return false 
        else count = count + 1 end

    end

    -- All keys are numerical. Now let's see if they are sequential and start with 1
    for i =1,count,1 do

        if t[i] == nil then return false end

    end

    return true

end

-- Returns the table with the module elements
return {

	RepeatPrevious = RepeatPrevious,
	MeanAll = MeanAll,
	MeanP = MeanP,
	MoreNumerousAll = MoreNumerousAll,
	MoreNumerousP = MoreNumerousP,
	IsArray = IsArray,

}