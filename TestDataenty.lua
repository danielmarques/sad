--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/22/2014
File: TestDataentry.lua
Title: Dataentry tests
Description: Unit tests for the data entry module.

################################################################################
--]]

local Dataentry = require "Dataentry"
local Saderrors = require "Saderrors"


describe("> #Dataentry", function ()

	-- LOAD INSTRUCTIONS TESTS
	describe("> #LoadExperiments", function()

		it("> Loads file instructions_001 and checks its content", function()

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

		it("> Loads file instructions_002 and checks its content", function()

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

		it("> Loads file instructions_003 and checks its content", function()

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

		it("> Loads file instructions_004 and checks its content", function()

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

		it("> Loads file instructions_005 with invalid format and and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("test_inputs/instructions_005") end, Saderrors.messages["INV_INST"])
				
		end)

		it("> Loads file instructions_006 with invalid format and and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("test_inputs/instructions_006") end, Saderrors.messages["INV_INST"])
				
		end)

		it("> Uses an invalid argument and throw the correct error", function ()

			assert.has_error(function () Dataentry.LoadExperiments({}) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Dataentry.LoadExperiments(1) end, Saderrors.messages["INV_ARG_SRT"])

		end)

		it("> Opens an inexistent file and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadExperiments("inexistent_file") end, Saderrors.messages["INV_INST"])
			assert.has_error(function () Dataentry.LoadExperiments("") end, Saderrors.messages["INV_INST"])

		end)

	end)

	-- LOAD DATA TESTS
	describe("> #Loaddata", function() 

		it("> Loads the file data_000 and checks its content", function()

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

		it("> Loads the file data_001 and checks its content", function()

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

		it("> Loads the file data_002 and checks its content", function()

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

		it("> Loads the file data_003 and checks its content", function()

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

		it("> Loads the file data_004 and checks its content", function()

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

		it("> Loads the file data_005 and checks its content", function()

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

		it("> Loads file data_006 with invalid format and and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadData("test_inputs/data_006") end, Saderrors.messages["INV_DATA"])
				
		end)

		it("> Uses an invalid argument and throw the correct error", function ()

			assert.has_error(function () Dataentry.LoadData({}) end, Saderrors.messages["INV_ARG_SRT"])
			assert.has_error(function () Dataentry.LoadData(1) end, Saderrors.messages["INV_ARG_SRT"])

		end)

		it("> Opens an inexistent file and throw the correct error", function()

			assert.has_error(function () Dataentry.LoadData("inexistent_file") end, Saderrors.messages["INV_DATA"])
			assert.has_error(function () Dataentry.LoadData("") end, Saderrors.messages["INV_DATA"])

		end)
	end)
end)