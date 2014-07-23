--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Advisor: Eduardo Sany Laber
Date: 07/17/2014
File: sad.lua
Title: sad
Description: Main module of the sistem. It must be executed via command line.

################################################################################
--]]

-- Modules
local Dataentry = require "Dataentry"
local Saderrors = require "Saderrors"

-- Variables
local debug = true

-- Code

print("SAD v 1.0, PUC-Rio\n")

print("Enter the path for the instructions file:")

local instFilePath = io.read()

print("\nTrying to read the instructions file: " .. instFilePath .. "\n")

local ok, ret = pcall(Dataentry.LoadExperiments, instFilePath)

if ok then
	for experimentNum, experiment in pairs(ret) do
		print("\nExecuting experiment number " .. experimentNum)

		--print(experiment.data)

		for tag, value in pairs(experiment) do
			print(tag .. " = " .. value)
		end
	end
else
	print(Saderrors.messages["LOD_INS"])
	if debug then print("Description: " .. ret) end
end