--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/28/2014
File: Persistence.lua
Title: Persistence
Description: Module responsable for save data into files.

################################################################################
--]]

local Saderrors = require "Saderrors"

-- Function responsable for saving a string into a file
-- s, fileName: must be strings
function SaveString( srt, fileName )

	if srt == nil or type(srt) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	if fileName == nil or type(fileName) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	-- Saves the name of the current default output file
	local temp = io.output()

	-- Changes the default output file
	io.output(tostring(fileName))

	io.write(tostring(srt))

	io.output():close()

	-- Changes back to the old output file
	io.output(temp)

end

-- Function responsable for saving data into a file in csv format
-- data: Must be a table.
-- fileName: Must be a string
function SaveData ( data, fileName )

	if data == nil or type(data) ~= "table" then error(Saderrors.messages["INV_ARG_TAB"]) end

	if fileName == nil or type(fileName) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	-- Saves the name of the current default output file
	local temp = io.output()

	-- Changes the default output file
	io.output(tostring(fileName))

	for k, v in pairs(data) do

		if type(v) == "table" and v.real ~= nil and v.predicted ~=nil then

			io.write(string.format("%s, %s\n", tostring(v.real), tostring(v.predicted)))

		else

			io.output():close(); io.output(temp)
			error(Saderrors.messages["INV_DATA_FOR_STAT"])

		end
	end

	io.output():close()

	-- Changes back to the old output file
	io.output(temp)

end

-- Returns the table with the module elements
return {

	SaveString = SaveString,
	SaveData = SaveData,
}