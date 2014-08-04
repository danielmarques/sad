--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/29/2014
File: sad.lua
Title: sad
Description: Main module of the sistem. It must be executed via command line.

################################################################################
--]]

-- Modules
local Saderrors = require "Saderrors"
local Dataentry = require "Dataentry"
local Prediction = require "Prediction"
local Statistics = require "Statistics"
local Persistence = require "Persistence"

-- Auxiliary functions

-- Function that returns the function/options from the module Prediciton to be used as the prediction strategy
-- srt: must be a string
local function selectStrategy( srt )

	if type(srt) ~= "string" then error(Saderrors.messages["INV_ARG_SRT"]) end

	local strategyTable = {
		RepeatPrevious = Prediction.RepeatPrevious,
		MeanAll = Prediction.MeanAll,
		MeanP = Prediction.MeanP,
		MoreNumerousAll = Prediction.MoreNumerousAll,
		MoreNumerousP = Prediction.MoreNumerousP,
	}

	local optionsTable = {
		MeanP = "p",
		MoreNumerousP = "p",
	}

	return strategyTable[srt], optionsTable[srt]

end

-- Variables
local verbose, debug = true, false
local instFilePath

-- Main code
for i = 1,10,1 do

	if arg[i] == "-s" then verbose = false end
	if arg[i] == "-d" then debug = true end
	if arg[i] == "-i" then instFilePath = arg[i+1] end

end

if verbose then

	print("SAD v 1.0, PUC-Rio")
	if debug then print("Debug mode. More detailed error messages will be displayed.\n") end
	if instFilePath then print("Trying to read the instructions file: " .. instFilePath) end

end

-- Loads instruction file
local ok, ret_inst = pcall(Dataentry.LoadExperiments, instFilePath)

if ok then

	-- Iterate over all experiments defined in the file
	for experimentNum, experiment in pairs(ret_inst) do

		-- Print experiment information
		if verbose then
			
			print("\nExecuting experiment number " .. experimentNum)
			print("Parameters:")

			for tag, value in pairs(experiment) do

				if type(value) == "table" then print(tag .. " = table")
				else print(tag .. " = " .. value) end

			end
		end

		-- Tests the experiment obrigatory parameters: data
		if experiment.data == nil and verbose then print(Saderrors.messages["MISS_DATA"]) 

		
		else 

			-- Tests the experiment obrigatory parameters: strategy
			if experiment.strategy == nil and verbose then print(Saderrors.messages["MISS_STRA"])

			else
				
				-- Loads the data file
				local ok, retData = pcall(Dataentry.LoadData, experiment.data)

				if ok then					
					
					-- Selects and executes the strategy
					local strategyFunction, strategyOption = selectStrategy(experiment.strategy)
					ok, retData = pcall(strategyFunction, retData, experiment[strategyOption])

					if ok then 

						-- Calculates the statistics
						local ok, correct, incorrect = pcall(Statistics.Correctness, retData)

						if not ok and verbose then

							print(Saderrors.messages["CALC_STAT"])
							if debug then print("Description: " .. correct) end

						end

						local ok, mae = pcall(Statistics.MeanAbsError, retData)

						if not ok and verbose then

							print(Saderrors.messages["CALC_STAT"])
							if debug then print("Description: " .. mae) end

						end

						local ok, rmse = pcall(Statistics.RootMeanSqrtError, retData)

						if not ok and verbose then

							print(Saderrors.messages["CALC_STAT"])
							if debug then print("Description: " .. rmse) end

						end 

						-- Format the string with the result and print
						local resultText
						resultText = "Percenual of correctiness: " .. (correct / (correct + incorrect))*100 .. " %\n"
						resultText = resultText .. "Number of correct instances: " .. correct .. "\n"
						resultText = resultText .. "Number of incorrect instances: " .. incorrect .. "\n"
						resultText = resultText .. "Total number of instances: " .. correct  + incorrect .. "\n"
						resultText = resultText .. "Mean Absolute Error: " .. mae .. "\n"
						resultText = resultText .. "Root Mean Squared Error: " .. rmse .. "\n"					

						if verbose then print("\nResults:\n" .. resultText) end

						-- Save the results on files
						local dateTime = os.date("%m-%d-%Y(%X)")

						local ok, msg = pcall(Persistence.SaveString, resultText, "result_stat_" .. experimentNum .. "-" .. dateTime)

						if ok and verbose then print("Results saved on file: " .. "result_stat_" .. experimentNum .. "-" .. dateTime)

						else if verbose then

								print(Saderrors.messages["SAVE_RES"])
								if debug then print("Description: " .. msg) end

							end
						end 

						ok, msg = pcall(Persistence.SaveData, retData, "result_data_" .. experimentNum .. "-" .. dateTime)

						if ok and verbose then print("Data saved on file: " .. "result_data_" .. experimentNum .. "-" .. dateTime .. "\n")

						else if verbose then

								print(Saderrors.messages["SAVE_RES"])
								if debug then print("Description: " .. msg) end
							end
						end

					else

						if verbose then
							print(Saderrors.messages["EXEC_STRAT"])
							if debug then print("Description: " .. retData) end
						end
					end

				else

					if verbose then
						print(Saderrors.messages["LOD_DATA"])
						if debug then print("Description: " .. retData) end
					end
				end
			end 
		end
	end
else if verbose then 

		print(Saderrors.messages["LOD_INS"])
		if debug then print("Description: " .. ret_inst) end

	end
end