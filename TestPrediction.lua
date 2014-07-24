--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/23/2014
File: TestPrediction.lua
Title: Prediction tests
Description: Unit tests for the prediction module.

################################################################################
--]]

local Prediction = require "Prediction"
local Saderrors = require "Saderrors"


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
		it("> Tests the strategy MeanAll with a valid input", function() 

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
		it("> Tests the strategy MoreNumerousAll with a valid input", function() 

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

	-- OTHER
	describe("> #other", function() 

		it("> Tests if it is an array", function() 

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