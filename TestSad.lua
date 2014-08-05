--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/23/2014
File: TestSad.lua
Title: SAD tests
Description: Unit tests for all modules of the sistem.

IMPORTANT: 

1 - The folder test_inputs, along with all inputs designed for the unit tests, is 
required in order to run all the following tests.

2 - The library lfs is also required to run the tests. You can download and install
this library via LuaRocks.

3 - A linux enviroment is required to run all tests below #sad.

4 - In order to run all the tests below #sad it is necessary to clear ALL RESULT 
FILES from previous executions of SAD.

################################################################################
--]]

-- Modules

local Saderrors = require "Saderrors"
local Dataentry = require "Dataentry"
local Prediction = require "Prediction"
local Statistics = require "Statistics"
local Persistence = require "Persistence"
local lfs = require "lfs"

-- ################################################################################
-- Unit tests for the data entry module.
describe("> #dataentry", function ()

	-- LOAD INSTRUCTIONS TESTS
	describe("> #loadexperiments", function()

		it("> Loads the file instructions_001 and checks its content", function()

			local instFilePath = "test_inputs/instructions_001"
			local experiments = Dataentry.LoadExperiments(instFilePath)
			local numExperiments = 0

			for experimentNum, experiment in pairs(experiments) do

				-- Verify if is able to get the experiment number
				assert.truthy(experimentNum)

				numExperiments = numExperiments + 1

				for tag, value in pairs(experiment) do
					-- Verify if is able to get the tags and values of the experiment definition
					assert.truthy(tag)
					assert.truthy(value)
				end
			end	

			-- Verify the number of experiments
			assert.are.same(numExperiments, 3)
				
		end)

		it("> Loads the file instructions_002 and checks its content", function()

			local instFilePath = "test_inputs/instructions_002"
			local experiments = Dataentry.LoadExperiments(instFilePath)
			local numExperiments = 0

			for experimentNum, experiment in pairs(experiments) do

				-- Verify if is able to get the experiment number
				assert.truthy(experimentNum)

				numExperiments = numExperiments + 1

				for tag, value in pairs(experiment) do
					-- Verify if is able to get the tags and values of the experiment definition
					assert.truthy(tag)
					assert.truthy(value)
				end
			end

			-- Verify the number of experiments
			assert.are.same(numExperiments, 0)
				
		end)

		it("> Loads the file instructions_003 and checks its content", function()

			local instFilePath = "test_inputs/instructions_003"
			local experiments = Dataentry.LoadExperiments(instFilePath)
			local numExperiments = 0

			for experimentNum, experiment in pairs(experiments) do

				-- Verify if is able to get the experiment number
				assert.truthy(experimentNum)

				numExperiments = numExperiments + 1

				for tag, value in pairs(experiment) do
					-- Verify if is able to get the tags and values of the experiment definition
					assert.truthy(tag)
					assert.truthy(value)
				end
			end

			-- Verify the number of experiments
			assert.are.same(numExperiments, 1)
				
		end)

		it("> Loads the file instructions_004 and checks its content", function()

			local instFilePath = "test_inputs/instructions_004"
			local experiments = Dataentry.LoadExperiments(instFilePath)
			local numExperiments = 0

			for experimentNum, experiment in pairs(experiments) do

				-- Verify if is able to get the experiment number
				assert.truthy(experimentNum)

				numExperiments = numExperiments + 1

				for tag, value in pairs(experiment) do
					-- Verify if is able to get the tags and values of the experiment definition
					assert.truthy(tag)
					assert.truthy(value)
				end
			end

			-- Verify the number of experiments
			assert.are.same(numExperiments, 300)
				
		end)

		it("> Loads the file instructions_005 with invalid format and and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("test_inputs/instructions_005") end, Saderrors.messages["INV_INST"])
				
		end)

		it("> Loads the file instructions_006 with invalid format and and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("test_inputs/instructions_006") end, Saderrors.messages["INV_INST"])
				
		end)

		it("> Uses invalid arguments and throw the correct error", function ()

			assert.has_error(function () Dataentry.LoadExperiments({}) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Dataentry.LoadExperiments(1) end, Saderrors.messages["INV_ARG_SRT"])

		end)

		it("> Opens inexistent files and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("inexistent_file") end, Saderrors.messages["INV_INST"])
			assert.has_error(function () Dataentry.LoadExperiments("") end, Saderrors.messages["INV_INST"])

		end)

	end)

	-- LOAD DATA TESTS
	describe("> #loaddata", function() 

		it("> Loads the valid file data_000 and checks its content", function()

			local dataFilePath = "test_inputs/data_000"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "string")
				assert.True(tonumber(instance.real) ~= nil)

			end

			assert.are.same(numInstances, 1)

		end)

		it("> Loads the valid file data_001 nd checks its content", function()

			local dataFilePath = "test_inputs/data_001"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "string")
				assert.True(tonumber(instance.real) ~= nil)

			end

			assert.are.same(numInstances, 20)

		end)

		it("> Loads the valid data_002 file and checks its content", function()

			local dataFilePath = "test_inputs/data_002"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "string")
				assert.True(tonumber(instance.real) ~= nil)

			end

			assert.are.same(numInstances, 10000)

		end)

		it("> Loads the valid file data_003 and checks its content", function()

			local dataFilePath = "test_inputs/data_003"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "string")
				assert.truthy(string.find(instance.real, "CLASS"))

			end

			assert.are.same(numInstances, 10)

		end)

		it("> Loads the valid file data_004 and checks its content", function()

			local dataFilePath = "test_inputs/data_004"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "number")

			end

			assert.are.same(numInstances, 4)

		end)

		it("> Loads the valid file data_005 and checks its content", function()

			local dataFilePath = "test_inputs/data_005"
			local data = Dataentry.LoadData(dataFilePath)
			local numInstances = 0

			for instanceNum, instance in pairs(data) do
				
				numInstances = numInstances + 1

				assert.truthy(instanceNum)
				assert.True(type(instanceNum) == "number")
				assert.True(type(instance) == "table")
				assert.truthy(instance.real)
				assert.True(type(instance.real) == "number")

			end

			assert.are.same(numInstances, 15)

		end)

		it("> Loads the file data_006 with invalid format and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadData("test_inputs/data_006") end, Saderrors.messages["INV_DATA"])
				
		end)

		it("> Uses invalid arguments and throw the correct error", function ()

			assert.has_error(function () Dataentry.LoadData({}) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Dataentry.LoadData(1) end, Saderrors.messages["INV_ARG_SRT"])

		end)

		it("> Opens inexistent files and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadData("inexistent_file") end, Saderrors.messages["INV_DATA"])
			assert.has_error(function () Dataentry.LoadData("") end, Saderrors.messages["INV_DATA"])

		end)
	end)
end)

-- ################################################################################
-- Unit tests for the prediction module.
describe("> #prediction", function()

	-- STRATEGY: REPREAT PREVIOUS
	describe("> #repeatprevious", function()
		it("> Tests the strategy RepeatPrevious with a valid input", function() 

			local data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = 5},}

			local newData = Prediction.RepeatPrevious(data)

			assert.True(newData[1].predicted == nil)

			for i = 2, #newData, 1 do

				assert.are.same(newData[i-1].real, newData[i].predicted)

			end
		end)

		it("> Tests the strategy RepeatPrevious with a valid input 2", function() 

			local data = {{real = 1.1}, {real = 2.2}, {real = 3.3}, {real = 4.4}, {real = 5.5},}

			local newData = Prediction.RepeatPrevious(data)

			for k, v in pairs (newData) do

				assert.are.same(data[k].real, v.real)

			end

		end)

		it("> Tests the strategy RepeatPrevious with a valid input 3", function() 

			local data = {{real = "1.1"}, {real = "2.2"}, {real = "3.3"}, {real = "4.4"}, {real = "5.5"},}

			local newData = Prediction.RepeatPrevious(data)

			for k, v in pairs (newData) do

				assert.are.same(data[k].real, v.real)

			end

		end)

		it("> Tests the strategy RepeatPrevious with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Prediction.RepeatPrevious("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.RepeatPrevious(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.RepeatPrevious() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the strategy RepeatPrevious with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Prediction.RepeatPrevious(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {1,2,3,4}
			assert.has_error(function () Prediction.RepeatPrevious(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {{real = 1},{real = 2},{real = 3},{4},{real = 5},}		
			assert.has_error(function () Prediction.RepeatPrevious(data) end, Saderrors.messages["INV_DATA_FOR"])

		end)
	end)

	-- STRATEGY: MEAN ALL
	describe("> #meanall", function()
		it("> Tests the strategy MeanAll with a valid input 1", function() 

			local data = {{real = 1.1},{real = 2.2},{real = 3.3},{real = 4.4},{real = 5.5},}

			local newData = Prediction.MeanAll(data)

			for i = 1, #newData, 1 do

				assert.are.same(3.3, newData[i].predicted)
				assert.are.same(data[i].real, newData[i].real)

			end
		end)

		it("> Tests the strategy MeanAll with a valid input 2", function() 

			local data = {key1 = {real = 1}, key2 = {real = 2}, {real = 3}, key4 = {real = 4}, key5 = {real = 5},}

			local newData = Prediction.MeanAll(data)

			for k, v in pairs (newData) do

				assert.are.same(3, v.predicted)
				assert.are.same(data[k].real, newData[k].real)

			end
		end)

		it("> Tests the strategy MeanAll with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Prediction.MeanAll("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MeanAll(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MeanAll() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the strategy MeanAll with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {1,2,3,4}
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {{real = 1},{real = 2},{real = 3},{real = 4},{5},}			
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_DATA_FOR"])

		end)

		it ("> Tests the strategy MeanAll with invalid mean argument format and throw the corresponding error", function()

			local data = {{real = 1},{real = false},{real = 3},{real = 4},{real = 5},}
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_ARG_MEAN"])

			local data = {{real = "1"},{real = 2},{real = 3},{real = 4},{real = 5},}
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_ARG_MEAN"])

			local data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = {5}},}			
			assert.has_error(function () Prediction.MeanAll(data) end, Saderrors.messages["INV_ARG_MEAN"])

		end)
	end)

	-- MEAN P
	describe("> #meanp", function()
		it("> Tests the strategy MeanP with a valid input", function() 

			local data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = 5},{real = 2},{real = 2},{real = 2},{real = 2},{real = 2},}

			local newData = Prediction.MeanP(data, 4)

			for i = 1, #newData, 1 do

				assert.are.same(data[i].real, newData[i].real)

			end

			assert.are.same(nil, newData[1].predicted)
			assert.are.same(1, newData[2].predicted)
			assert.are.same(1.5, newData[3].predicted)
			assert.are.same(2, newData[4].predicted)
			assert.are.same(2.5, newData[5].predicted)
			assert.are.same(3.5, newData[6].predicted)
			assert.are.same(3.5, newData[7].predicted)
			assert.are.same(3.25, newData[8].predicted)
			assert.are.same(2.75, newData[9].predicted)
			assert.are.same(2, newData[10].predicted)

		end)

		it("> Tests the strategy MeanP with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Prediction.MeanP("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MeanP(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MeanP() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the strategy MeanP with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {1,2,3,4}
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {{real = 1},{real = 2},{real = 3},{4},{real = 5},}		
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_DATA_FOR"])

			--Array format
			local data = {{real = 1},key = {real = 2},{real = 3},{real = 4},{real = 5},}			
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_DATA_FOR"])

		end)

		it ("> Tests the strategy MeanP with invalid mean argument format and throw the corresponding error", function()

			local data = {{real = 1},{real = false},{real = 3},{real = 4},{real = 5},}
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_ARG_MEAN"])

			local data = {{real = "1"},{real = 2},{real = 3},{real = 4},{real = 5},}
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_ARG_MEAN"])

			local data = {{real = 1},{real = 2},{real = {3}},{real = 4},{real = 5},}			
			assert.has_error(function () Prediction.MeanP(data) end, Saderrors.messages["INV_ARG_MEAN"])

		end)
	end)

	-- STRATEGY: MORE NUMEROUS ALL
	describe("> #morenumerousall", function()
		it("> Tests the strategy MoreNumerousAll with a valid input 1", function() 

			local data = {{real = "a"},{real = "b"},{real = "b"},{real = "c"},{real = "d"},}

			local newData = Prediction.MoreNumerousAll(data)			

			for i = 1, #newData, 1 do

				assert.are.same("b", newData[i].predicted)
				assert.are.same(data[i].real, newData[i].real)

			end
		end)

		it("> Tests the strategy MoreNumerousAll with a valid input 2", function() 

			local data = {{real = "a"},{real = "b"},{real = "b"},{real = "c"},{real = "d"},{real = 1},{real = "b"},{real = "b"},
			{real = {"c"}},{real = "d"},}

			local newData = Prediction.MoreNumerousAll(data)			

			for i = 1, #newData, 1 do

				assert.are.same("b", newData[i].predicted)
				assert.are.same(data[i].real, newData[i].real)

			end
		end)

		it("> Tests the strategy MoreNumerousAll with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Prediction.MoreNumerousAll("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MoreNumerousAll(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MoreNumerousAll() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the strategy MoreNumerousAll with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Prediction.MoreNumerousAll(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {1,2,3,4}
			assert.has_error(function () Prediction.MoreNumerousAll(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {{real = 1},{real = 2},{real = 3},{real = 4},{5},}		
			assert.has_error(function () Prediction.MoreNumerousAll(data) end, Saderrors.messages["INV_DATA_FOR"])

		end)
	end)

	-- STRATEGY: MORE NUMEROUS P
	describe("> #morenumerousp", function()
		it("> Tests the strategy MoreNumerousP with a valid input 1", function() 

			local data = {{real = "a"},{real = "b"},{real = "b"},{real = "c"},{real = "d"},{real = "a"},{real = "b"},{real = "b"},
			{real = "c"},{real = "d"},}

			local newData = Prediction.MoreNumerousP(data, 4)			

			for i = 1, #newData, 1 do

				assert.are.same(data[i].real, newData[i].real)

			end

			assert.are.same(nil, newData[1].predicted)
			assert.are.same("a", newData[2].predicted)
			assert.True("a" == newData[3].predicted or "b" == newData[3].predicted)
			assert.are.same("b", newData[4].predicted)
			assert.are.same("b", newData[5].predicted)
			assert.are.same("b", newData[6].predicted)
			assert.True("a" == newData[7].predicted or "b" == newData[7].predicted or "c" == newData[7].predicted or "d" == newData[7].predicted)
			assert.True("a" == newData[8].predicted or "b" == newData[8].predicted or "c" == newData[8].predicted or "d" == newData[8].predicted)
			assert.are.same("b", newData[9].predicted)
			assert.are.same("b", newData[10].predicted)

		end)

		it("> Tests the strategy MoreNumerousP with a valid input 2", function() 

			local data = {{real = 1},{real = 1},{real = 2},{real = 2},{real = 3},{real = 3},{real = 4},{real = 4},
			{real = {5}},{real = 5},}

			local newData = Prediction.MoreNumerousP(data, 3)			

			for i = 1, #newData, 1 do

				assert.are.same(data[i].real, newData[i].real)

			end

			assert.are.same(nil, newData[1].predicted)
			assert.are.same(1, newData[2].predicted)
			assert.are.same(1, newData[3].predicted)
			assert.are.same(1, newData[4].predicted)
			assert.are.same(2, newData[5].predicted)
			assert.are.same(2, newData[6].predicted)
			assert.are.same(3, newData[7].predicted)
			assert.are.same(3, newData[8].predicted)
			assert.are.same(4, newData[9].predicted)
			assert.are.same(4, newData[10].predicted)

		end)

		it("> Tests the strategy MoreNumerousP with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Prediction.MoreNumerousP("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MoreNumerousP(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Prediction.MoreNumerousP() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the strategy MoreNumerousP with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Prediction.MoreNumerousP(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {1,2,3,4}
			assert.has_error(function () Prediction.MoreNumerousP(data) end, Saderrors.messages["INV_DATA_FOR"])

			local data = {{real = 1},{real = 2},{real = 3},{4},{real = 5},}		
			assert.has_error(function () Prediction.MoreNumerousP(data) end, Saderrors.messages["INV_DATA_FOR"])

		end)
	end)

	-- OTHER
	describe("> #auxiliary", function() 

		it("> Tests if the input tables are arrays", function() 

			a = {1,2,3,4,5}
			assert.True(Prediction.IsArray(a))

			a = {"a","b","c","d"}
			assert.True(Prediction.IsArray(a))

			a = {{},{},{}}
			assert.True(Prediction.IsArray(a))

			a = {key1 = 1, key2 = 2, key3 = 3, key4 = 4, key5 = 5}
			assert.False(Prediction.IsArray(a))

			a = {1,2,key = 3,4,5}
			assert.False(Prediction.IsArray(a))

			a = {}
			a[1] = 1; a[2] = 2; a[4] = 4; a[5] = 5
			assert.False(Prediction.IsArray(a))

		end)
	end)
end)

-- ################################################################################
-- Unit tests for the statistics module.
describe("> #statistics", function()

	--FUNCTION: CORRECTINESS
	describe("> #correctness", function()

		it("> Tests the function Correctness with valid inputs", function()

			local data = {{real = 0.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 3}, {real = 4, predicted = 4}, {real = 5, predicted = 5},
			{real = 6, predicted = 6}, {real = 7, predicted = 7}, {real = 8, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			local c, i = Statistics.Correctness(data)

			assert.True(c == 10)
			assert.True(i == 0)

			data = {{real = "0.1", predicted = "0.1"}, {real = "2", predicted = "2"}, {real = "3", predicted = "3"}, {real = "4", predicted = "4"}, {real = "5", predicted = "5"},
			{real = "6", predicted = "6"}, {real = "7", predicted = "7"}, {real = "8", predicted = "8"}, {real = "9", predicted = "9"}, {real = "10000", predicted = "10000"},}

			c, i = Statistics.Correctness(data)

			assert.True(c == 10)
			assert.True(i == 0)

			data = {{real = "0.1", predicted = "0.1a"}, {real = "2", predicted = "2a"}, {real = "3a", predicted = "3"}, {real = "4a", predicted = "4"}, {real = "5", predicted = "5a"},
			{real = "6", predicted = "6b"}, {real = "7", predicted = "7b"}, {real = "8b", predicted = "8"}, {real = "9b", predicted = "9"}, {real = "10000", predicted = "10000c"},}

			c, i = Statistics.Correctness(data)

			assert.True(c == 0)
			assert.True(i == 10)

			data = {{real = "0.1", predicted = "0.1"}, {real = "2", predicted = "2"}, {real = "3a", predicted = "3"}, {real = "4a", predicted = "4"}, {real = "5", predicted = "5a"},
			{real = "6", predicted = "6"}, {real = "7", predicted = "7"}, {real = "8", predicted = "8"}, {real = "9b", predicted = "9"}, {real = "10000", predicted = "10000c"},}

			c, i = Statistics.Correctness(data)

			assert.True(c == 5)
			assert.True(i == 5)

			data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = 5},}
			c, i = Statistics.Correctness(data)

			assert.True(c == 0)
			assert.True(i == 5)

		end)

		it("> Tests the function Correctness with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Statistics.Correctness("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.Correctness(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.Correctness() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the function Correctness with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Statistics.Correctness(data) end, Saderrors.messages["INV_DATA_FOR_STAT"])

			local data = {1,2,3,4}
			assert.has_error(function () Statistics.Correctness(data) end, Saderrors.messages["INV_DATA_FOR_STAT"])

		end)
	end)

	--FUNCTION: MEAN ABSOLUTE ERROR
	describe("> #meanabserror", function()

		it("> Tests the fucntion MeanAbsError with valid inputs", function()

			-- Test 1
			local data = {{real = 0.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 3}, {real = 4, predicted = 4}, {real = 5, predicted = 5},
			{real = 6, predicted = 6}, {real = 7, predicted = 7}, {real = 8, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			local mae = Statistics.MeanAbsError(data)

			assert.True(mae == 0)

			-- Test 2
			data = {{real = 1.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 3}, {real = 4, predicted = 4}, {real = 5, predicted = 5},
			{real = 7, predicted = 6}, {real = 8, predicted = 7}, {real = 9, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			mae = Statistics.MeanAbsError(data)

			assert.True(mae == 0.4)

			-- Test 3
			data = {{real = 1.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 4}, {real = 4, predicted = 4.1}, {real = 5.1, predicted = 5},
			{real = 7, predicted = 6}, {real = 8, predicted = 7}, {real = 9, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			mae = Statistics.MeanAbsError(data)

			assert.are.same(tostring(0.52), tostring(mae))

			-- Test 4
			data = {}

			mae = Statistics.MeanAbsError(data)

			assert.True(mae == 0)

			-- Test 5
			data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = 5},}

			mae = Statistics.MeanAbsError(data)

			assert.True(mae == 0)

		end)

		it("> Tests the function MeanAbsError with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Statistics.MeanAbsError("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.MeanAbsError(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.MeanAbsError() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the function MeanAbsError with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Statistics.MeanAbsError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])

			data = {1,2,3,4}
			assert.has_error(function () Statistics.MeanAbsError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])	

			data = {{real = 1},{real = 2},{real = 3, predicted = "string"},{real = 4},{real = 5},}
			assert.has_error(function () Statistics.MeanAbsError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])			
		end)
	end)

	--FUNCTION: ROOT MEAN SQUARED ERROR
	describe("> #rootmeansqrterror", function()

		it("> Tests the function RootMeanSqrtError with a valid inputs", function()

			-- Test 1
			local data = {{real = 0.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 3}, {real = 4, predicted = 4}, {real = 5, predicted = 5},
			{real = 6, predicted = 6}, {real = 7, predicted = 7}, {real = 8, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			local mae = Statistics.RootMeanSqrtError(data)

			assert.True(mae == 0)

			-- Test 2
			data = {{real = 1.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 3}, {real = 4, predicted = 4}, {real = 5, predicted = 5},
			{real = 7, predicted = 6}, {real = 8, predicted = 7}, {real = 9, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			mae = Statistics.RootMeanSqrtError(data)

			assert.True(tostring(mae) == tostring(math.sqrt(0.4)))

			-- Test 3
			data = {{real = 1.1, predicted = 0.1}, {real = 2, predicted = 2}, {real = 3, predicted = 4}, {real = 4, predicted = 4.1}, {real = 5.1, predicted = 5},
			{real = 7, predicted = 6}, {real = 8, predicted = 7}, {real = 9, predicted = 8}, {real = 9, predicted = 9}, {real = 10000, predicted = 10000},}

			mae = Statistics.RootMeanSqrtError(data)

			assert.are.same(tostring(math.sqrt(0.502)), tostring(mae))

			-- Test 4
			data = {}

			mae = Statistics.RootMeanSqrtError(data)

			assert.True(mae == 0)

			-- Test 5
			data = {{real = 1},{real = 2},{real = 3},{real = 4},{real = 5},}

			mae = Statistics.RootMeanSqrtError(data)

			assert.True(mae == 0)

		end)

		it("> Tests the function RootMeanSqrtError with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Statistics.RootMeanSqrtError("invalid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.RootMeanSqrtError(1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Statistics.RootMeanSqrtError() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it ("> Tests the function RootMeanSqrtError with invalid data format and throw the corresponding error", function()

			local data = {{key = 1},{key = 2},{key = 3},{key = 4},{key = 5},}
			assert.has_error(function () Statistics.RootMeanSqrtError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])

			data = {1,2,3,4}
			assert.has_error(function () Statistics.RootMeanSqrtError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])

			data = {{real = 1},{real = 2},{real = 3, predicted = "string"},{real = 4},{real = 5},}
			assert.has_error(function () Statistics.RootMeanSqrtError(data) end, Saderrors.messages["INV_DATA_FOR_STAT_NUM"])

		end)
	end)
end)

describe("> #persistence", function()

	-- SAVE STRING
	describe("> #savestring", function()

		it("> Uses the function SaveString to saves strings into a files and checks the contents", function()

			-- Test 1
			local srt = "A short string."
			local fileName = "sad_test_file"
			Persistence.SaveString(srt, fileName)
			local f = io.open(fileName, "r")
			local retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			-- Test 2
			srt = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
			Persistence.SaveString(srt, fileName)
			f = io.open(fileName, "r")
			retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			-- Test 3
			srt = "100000.0000001"
			Persistence.SaveString(srt, fileName)
			f = io.open(fileName, "r")
			retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			os.remove(fileName)

		end)

		it("> Tests the function SaveString with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Persistence.SaveString("valid argument", 1) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Persistence.SaveString(1, "valid argument") end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Persistence.SaveString() end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Persistence.SaveString("valid argument", {}) end, Saderrors.messages["INV_ARG_SRT"])

		end)
	end)

	-- SAVE DATA
	describe("> #savedata", function()

		it("> Uses the function SaveData to save tables with data into files and checks the contents", function()

			-- Test 1
			local data = {{real = 0.1, predicted = 0.1}, {real = 2, predicted = 2},}
			local srt = "0.1, 0.1\n2, 2\n"
			local fileName = "sad_test_file"
			Persistence.SaveData(data, fileName)
			local f = io.open(fileName, "r")
			local retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			-- Test 2
			data = {{real = "0.1", predicted = "0.1"}, {real = "2", predicted = "2"},}
			srt = "0.1, 0.1\n2, 2\n"
			Persistence.SaveData(data, fileName)
			f = io.open(fileName, "r")
			retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			-- Test 3
			data = {{real = "class 1", predicted = "class 1"}, {real = "class 2", predicted = "class 2"},
			{real = "class 3", predicted = "class 1"}, {real = "class 4", predicted = "class 2"},}
			srt = "class 1, class 1\nclass 2, class 2\nclass 3, class 1\nclass 4, class 2\n"
			Persistence.SaveData(data, fileName)
			f = io.open(fileName, "r")
			retSrt = f:read("*a")
			f:close()

			assert.are.same(srt, retSrt)

			os.remove(fileName)

		end)

		it("> Tests the function SaveData with invalid arguments and throw the corresponding error", function() 

			assert.has_error(function () Persistence.SaveData("invalid argument", 1) end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Persistence.SaveData(1, "valid argument") end, Saderrors.messages["INV_ARG_TAB"])
			assert.has_error(function () Persistence.SaveData({}, 1) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Persistence.SaveData({}, {}) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Persistence.SaveData() end, Saderrors.messages["INV_ARG_TAB"])

		end)

		it("> Tests the function SaveData with invalid data format and throw the corresponding error", function() 

			local data = {1,2,3,4,5}
			assert.has_error(function () Persistence.SaveData(data, "file_name") end, Saderrors.messages["INV_DATA_FOR_STAT"])

			data = {key1 = 1, key2 = 2, key3 = 3, key4 = 4, key5 = 5}
			assert.has_error(function () Persistence.SaveData(data, "file_name") end, Saderrors.messages["INV_DATA_FOR_STAT"])

			data = {{key = "1", predicted = "0.1"}, {real = "2", predicted = "2"},}
			assert.has_error(function () Persistence.SaveData(data, "file_name") end, Saderrors.messages["INV_DATA_FOR_STAT"])

		end)
	end)
end)

describe("> #sad", function()

	it("> #Tests the main program with valid inputs.", function()

		local resultFileName

		-- TEST 1
		_ENV.arg = {"-s", "-i", "test_inputs/instructions_007"}		
		local sad = loadfile("sad.lua", "t", _ENV)
		sad()

		-- Find and tests the statistics file
		for file in lfs.dir(".") do

			if file:find("result_s") then resultFileName = file; break end

		end

		local f = io.open(resultFileName, "r")
		local resultContent = f:read("*a")
		f:close()
		os.execute("rm result_s*")

		local expectedContent = [[Percenual of correctiness: 0 %
Number of correct instances: 0
Number of incorrect instances: 10
Total number of instances: 10
Mean Absolute Error: 1
Root Mean Squared Error: 1
]]
		assert.are.same(expectedContent, resultContent)

		-- Find and tests the data file
		for file in lfs.dir(".") do

			if file:find("result_d") then resultFileName = file; break end

		end

		f = io.open(resultFileName, "r")
		resultContent = f:read("*a")
		f:close()
		os.execute("rm result_d*")

		expectedContent = [[1, nil
2, 1
3, 2
4, 3
5, 4
6, 5
7, 6
8, 7
9, 8
10, 9
]]

		assert.are.same(expectedContent, resultContent)

		-- TEST 2
		_ENV.arg = {"-s", "-i", "test_inputs/instructions_008"}		
		sad = loadfile("sad.lua", "t", _ENV)
		sad()

		-- Find and tests the statistics file
		for file in lfs.dir(".") do

			if file:find("result_s") then resultFileName = file; break end

		end

		f = io.open(resultFileName, "r")
		resultContent = f:read("*a")
		f:close()
		os.execute("rm result_s*")

		expectedContent = [[Percenual of correctiness: 33.333333333333 %
Number of correct instances: 4
Number of incorrect instances: 8
Total number of instances: 12
Mean Absolute Error: 1.3333333333333
Root Mean Squared Error: 1.6329931618555
]]
		assert.are.same(expectedContent, resultContent)

		-- Find and tests the data file
		for file in lfs.dir(".") do

			if file:find("result_d") then resultFileName = file; break end

		end

		f = io.open(resultFileName, "r")
		resultContent = f:read("*a")
		f:close()
		os.execute("rm result_d*")

		expectedContent = [[10, 10
10, 10
10, 10
10, 10
8, 10
8, 10
8, 10
8, 10
12, 10
12, 10
12, 10
12, 10
]]

		assert.are.same(expectedContent, resultContent)

	end)
end)