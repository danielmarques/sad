--[[
################################################################################
################### SAD - Sistema de Avaliação de Desempenho ###################
######################## Projeto de Programação 2014.1 #########################

Autor: Daniel da Rosa Marques
Data: 17/07/2014
Arquivo: sad.lua
Título: sad
Descrição: Módulo principal do sistema. Deve ser executado via linha de comando 
pelo usuário.

################################################################################
--]]
local Dataentry = require "Dataentry"

print("SAD - Sistema de Avaliação de Desempenho")
print("Projeto de Programação 2014.1")
print("\nAluno: Daniel da Rosa Marques")
print("Orientador: Eduardo Sany Laber\n\n")

print("Insira o caminho para o arquivo de instruções:")

instFilePath = io.read()

print("\nTentando ler o arquivo de instruções: " .. instFilePath .. "\n")

local experiments = Dataentry.LoadExperiments(instFilePath)

for experimentNum, experiment in pairs(experiments) do
	print("\nExecutando o experimento número " .. experimentNum)

	--print(experiment.data)

	for tag, value in pairs(experiment) do
		print(tag .. " = " .. value)
	end
end