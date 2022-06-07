
local admin = {"Shootera"} -- Chef du Module
tfm.exec.disableAutoNewGame(true) -- Désactivation de changement automatique de carte.
tfm.exec.disableAutoShaman(true) -- Tant qu'on y est on empêche la sélection d'une chamane sur les cartes.
tfm.exec.disableAutoTimeLeft(true) -- Désactive le timer
ListeMap = {1, 2} -- La liste des map du jeu Wormice
local gameRunning = false -- Savoir si une partie est en cours

local nomEquipe = { -- La liste des noms des Équipes
	"Rouge",
	"Bleu",
	"Jaune",
	"Vert"
}

local sourisEquipe = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
}

local joueursInGame = {} -- Liste des joueurs dans la partie

local listeCouleurs = { -- La couleur des équipes
	[1] = "0xff0000",
	[2] = "0x0000ff",
	[3] = "0xffff00 ",
	[4] = "0x008000"
}

function wait(seconds) -- Fonction qui vas attendre
	local start = os.time()
	repeat until os.time() > start + seconds
end

function remplirEquipe()
	local i = 0 -- Le compteur de souris dans la salle
	local indiceEquipe = 1 -- Savoir dans quelle équipe on rajoute la souris
   	for _, prop in pairs(tfm.get.room.playerList) do -- pour chaque joueur du salon ...
   		table.insert(joueursInGame, prop.playerName) -- On ajoute chaque joueur a une liste
   		table.insert(sourisEquipe[indiceEquipe], prop.playerName) -- On ajoute le joueur a l'équipe
   		tfm.exec.setNameColor(prop.playerName, listeCouleurs[indiceEquipe]) -- On met la couleur de l'équipe a la souris
   		if indiceEquipe == 4 then -- On revien a 1 des qu'on est a l'équipe 4
   			indiceEquipe = 1
   		else
   			indiceEquipe = indiceEquipe + 1 -- On augmente l'indice dans lequel on doit rajouter les souris
   		end
   	end
end


function pseudoCouleur() -- Fonction qui colories les pseudos des souris selon leurs équipes
	for i, nbSourisRouge in pairs(sourisEquipe[1]) do tfm.exec.setNameColor(nbSourisRouge, listeCouleurs[1]) end -- Pseudos des souris de l'équipe rouge en rouge
	for i, nbSourisBleu in pairs(sourisEquipe[2]) do tfm.exec.setNameColor(nbSourisBleu, listeCouleurs[2]) end -- Pseudos des souris de l'équipe bleu en bleu
	for i, nbSourisJaune in pairs(sourisEquipe[3]) do tfm.exec.setNameColor(nbSourisJaune, listeCouleurs[3]) end -- Pseudos des souris de l'équipe jaune en jaune
	for i, nbSourisVert in pairs(sourisEquipe[4]) do tfm.exec.setNameColor(nbSourisVert, listeCouleurs[4]) end -- Pseudos des souris de l'équipe vert en vert
end

function placementJoueur() -- Fonction qui positionne toutes les souris de façon random
	for i, sourisRouge in pairs(sourisEquipe[1]) do tfm.exec.movePlayer(sourisRouge, math.random(0,1000), math.random(0,1000), false, 0, 0, false) end -- Positionne les souris rouges de façon random
	for i, sourisBleu in pairs(sourisEquipe[2]) do tfm.exec.movePlayer(sourisBleu, math.random(0,1000), math.random(0,1000), false, 0, 0, false) end -- Positionne les souris rouges de façon random
	for i, sourisJaune in pairs(sourisEquipe[3]) do tfm.exec.movePlayer(sourisJaune, math.random(0,1000), math.random(0,1000), false, 0, 0, false) end -- Positionne les souris rouges de façon random
	for i, sourisVert in pairs(sourisEquipe[4]) do tfm.exec.movePlayer(sourisVert, math.random(0,1000), math.random(0,1000), false, 0, 0, false) end -- Positionne les souris rouges de façon random
end


function main() -- Fonction d'initiation du module
	system.disableChatCommandDisplay(nil) -- On désactive pas l'affichage des commande dans le chat
	tfm.exec.disableAutoNewGame(true) -- Désactivation de changement automatique de carte.
	tfm.exec.disableAutoShaman(true) -- Tant qu'on y est on empêche la sélection d'une chamane sur les cartes.
	tfm.exec.disableAutoTimeLeft(true) -- Désactive le timer
	tfm.exec.disableAfkDeath(true) -- Désactive la mort afk
	tfm.exec.newGame(ListeMap[math.random(#ListeMap)]) -- On charge un Lobby
	tfm.exec.setGameTime(99999)
end

main()
remplirEquipe()
pseudoCouleur()
placementJoueur()