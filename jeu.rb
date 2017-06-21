class Personne
	attr_accessor :nom, :points_de_vie, :en_vie

	def initialize(nom)
		@nom = nom
		@points_de_vie = 100
		@en_vie = true
	end

	def info
		if en_vie
			return "#{self.nom}: #{self.points_de_vie} PV"
		else
			return "#{self.nom}: Vaincu"
		end
	end


	def attaque(personne)
		degats_infliges = degats_inflige
		puts "#{self.nom} attaque #{personne.nom} !"
		puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
		personne.subit_attaque(degats_infliges)
		self.degats_inflige
	end

	def degats_inflige
		degats_inflige = degats
	end

	def charge
		self.fureur += 2
	end

	def coup_circulaire(personnes)
		 if @fureur < 3
          puts "Vous avez beau essayer, vous n'arrivez pas à réunir l'énergie nécessaire à cette attaque..."
		 else
				puts "#{self.nom} fait un coup circulaire !"
				puts "#{self.nom} inflige #{30 + degats_bonus} points de dégâts à tous les ennemis"
				personnes.each do | personne |
					personne.subit_attaque(self.degats_circulaire)
				end
				@fureur -= 3
				self.degats_circulaire
			end
	end

	def rafale(personne)
		 if @fureur < 5
          puts "Vous avez beau essayer, vous n'arrivez pas à réunir l'énergie nécessaire à cette attaque..."
		 else
				puts "#{self.nom} met une rafale de coups à #{personne.nom} !"
				puts "#{self.nom} inflige #{80 + degats_bonus * 2} points de dégâts à #{personne.nom}"
					personne.subit_attaque(self.degats_rafale)
				@fureur -= 5
				self.degats_rafale
			end
	end

	def subit_attaque(degats_recus)
		if @blocage == true
			bloque = 15
			self.points_de_vie -= (degats_recus - bloque)
			puts "#{self.nom} bloque #{bloque} points de dégâts, prend #{degats_recus - bloque} dégâts et a maintenant #{self.points_de_vie} PV !"
			@blocage = false
		else
			self.points_de_vie -= degats_recus
			puts "#{self.nom} prend #{degats_recus} dégâts et a maintenant #{self.points_de_vie} PV !"
		end
		if points_de_vie <= 0
			self.en_vie = false
			puts "#{self.nom} a été tué."
		else
			self.en_vie = true
			puts "#{self.nom} tient bon !"
		end
	end

end

class Jeu

	def self.actions_possibles(monde, joueur)
		if joueur.fureur >= 5
			puts "ACTIONS POSSIBLES :"

			puts "0 - Se soigner"
			puts "1 - Améliorer son attaque"
			puts "2 - Coup circulaire (Coût: 3 fureur)"
			puts "3 - Rafale de coups (Coût: 5 fureur)"
			puts "4 - Accumuler de la fureur"
			i = 5
			monde.ennemis.each do |ennemi|
				puts "#{i} - Attaquer #{ennemi.info}"
				i = i + 1
			end
			puts "99 - Quitter"
		elsif joueur.fureur >= 3
			puts "ACTIONS POSSIBLES :"

			puts "0 - Se soigner"
			puts "1 - Améliorer son attaque"
			puts "2 - Coup circulaire (Coût: 3 fureur)"
			puts "3 - Accumuler de la fureur"
			i = 4
			monde.ennemis.each do |ennemi|
				puts "#{i} - Attaquer #{ennemi.info}"
				i = i + 1
			end
			puts "99 - Quitter"
		else
			puts "ACTIONS POSSIBLES :"

			puts "0 - Se soigner"
			puts "1 - Améliorer son attaque"
			puts "2 - Accumuler de la fureur"
			i = 3
			monde.ennemis.each do |ennemi|
				puts "#{i} - Attaquer #{ennemi.info}"
				i = i + 1
			end
			puts "99 - Quitter"
		end
	end
	def self.est_fini(joueur, monde)

		ennemis_en_vie = 0
				
			monde.ennemis.each do |ennemi|
					ennemis_en_vie += 1 if ennemi.en_vie
			end

	 if joueur.en_vie == false || ennemis_en_vie <= 0
					return true
			else 
				return false
			end
	end
end

class Monde
														
	attr_accessor :ennemis, :choix
	  def initialize 
				@ennemis = []
				@choix = 0
		end

	def ennemis_en_vie
		@ennemis.select{|enn| enn.en_vie == true}
	end
end

puts "Veuillez choisir le niveau de difficulté de votre aventure : "
puts "O.Noob       - Soins du joueur maximums et dégâts des montres minimums"
puts "1.Facile     - Soins du joueur augmentés et dégâts des monstres réduits"
puts "2.Moyen      - Soins du joueur et dégâts des monstres modérés"
puts "3.Difficile  - Soins du joueur réduits et dégâts des monstres augmentés"
puts "4.Impossible - Soins du joueur minimums et dégâts des monstres maximums"
puts "5.Bonus      - Soins et dégâts totalement aléatoires"
difficulte = gets.to_i

if difficulte == 0

	class Joueur < Personne
			attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
				super(nom)
			end

				def info
		if en_vie
			return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
		else
			return "#{self.nom}: Vaincu"
		end
	end


			def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end


			def degats
				degats = rand(20..30) + degats_bonus
				return degats
			end

			def degats_circulaire
				degats_circulaire = 30 + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
				soin = rand(50..60)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def ameliorer_degats
				self.degats_bonus = rand(20...40)
				puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
			end
	end

	class Ennemi < Personne
		attr_accessor :blocage
			def initialize(nom)
				@nom = nom
				@points_de_vie = 100
				@en_vie = true
				@blocage = false
			end

			def degats
				degats = rand(1...5)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end

elsif difficulte == 1

	class Joueur < Personne
		attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
				super(nom)
			end

			def info
				if en_vie
					return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
				else
					return "#{self.nom}: Vaincu"
				end
			end

				 def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end


			def degats
				degats = rand(20..30) + degats_bonus
				return degats
		end

		 def degats_circulaire
				degats_circulaire = 30 + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
				soin = rand(40..50)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
		 end

			def ameliorer_degats
				self.degats_bonus = rand(20...40)
				puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
			end
	end

	class Ennemi < Personne
			def degats
				degats = rand(5...10)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end

elsif difficulte == 2

	class Joueur < Personne
			attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
				super(nom)
			end

			def info
				if en_vie
					return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
				else
					return "#{self.nom}: Vaincu"
				end
			end

				 def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end


			def degats
				degats = rand(20..30) + degats_bonus
				return degats
			end

			 def degats_circulaire
				degats_circulaire = 30 + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
				soin = rand(30..40)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def ameliorer_degats
				self.degats_bonus = rand(20...40)
				puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
			end
	end

class Ennemi < Personne
			def degats
				degats = rand(10...12)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end


elsif difficulte == 3

	class Joueur < Personne
			attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
				super(nom)
			end

			def info
				if en_vie
					return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
				else
					return "#{self.nom}: Vaincu"
				end
			end

				 def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end


			def degats
				degats = rand(20..30) + degats_bonus
				return degats
			end

			def degats_circulaire
				degats_circulaire = 30 + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
				soin = rand(25..35)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
		 end

		def ameliorer_degats
				self.degats_bonus = rand(20...40)
				puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
		end
	end

	class Ennemi < Personne
			def degats
				degats = rand(14...18)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end

elsif difficulte == 4

	class Joueur < Personne
			attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
					super(nom)
			end

			def info
				if en_vie
					return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
				else
					return "#{self.nom}: Vaincu"
				end
			end

			def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end
 
			def degats
				degats = rand(20..30) + degats_bonus
				return degats
			end

			def degats_circulaire
				degats_circulaire = 30 + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
					soin = rand(10..20)
					self.points_de_vie += soin
					puts "#{self.nom} récupère #{soin} PV !"
					return soin
			end

			def ameliorer_degats
					self.degats_bonus = rand(20...40)
					puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
			end
	end

	class Ennemi < Personne
		def degats
				degats = rand(20...25)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end

elsif difficulte == 5

	class Joueur < Personne
			attr_accessor :degats_bonus, :fureur

			def initialize(nom)
				@degats_bonus = 0
				@fureur = 0
				super(nom)
			end

			def info
				if en_vie
					return "#{self.nom}: #{self.points_de_vie} PV \n   #{@fureur} fureur"
				else
					return "#{self.nom}: Vaincu"
				end
			end

				 def attaque(personne)
				degats_infliges = degats_inflige
				puts "#{self.nom} attaque #{personne.nom} !"
				puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
				personne.subit_attaque(degats_infliges)
				self.degats_inflige
				@degats_bonus = 0
				@fureur += 1
			end


			def degats
				degats = rand(1..100) + degats_bonus
				return degats
			end

			 def degats_circulaire
				degats_circulaire = rand(1...100) + degats_bonus
				return degats_circulaire
			end

			def degats_rafale
				degats_rafale = 80 + degats_bonus * 2
				return degats_rafale
			end

			def soin
				soin = rand(1..100)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def ameliorer_degats
				self.degats_bonus = rand(1...100)
				puts "#{self.nom} augmente ses dégâts de #{degats_bonus} !"
			end
	end

	class Ennemi < Personne
			def degats
				degats = rand(1...100)
				return degats
			end

			def soin
				soin = rand(1..10)
				self.points_de_vie += soin
				puts "#{self.nom} récupère #{soin} PV !"
				return soin
			end

			def blocage
				@blocage = true
				return @blocage
			end
	end

else
	puts "Choix invalide, fermeture du jeu."
end
##############

monde = Monde.new

monde.ennemis = [
	Ennemi.new("Slime bleu"),
	Ennemi.new("Slime vert"),
	Ennemi.new("Slime rouge")
]


puts "Comment vous appelez-vous, Aventurier ?"
joueur = Joueur.new(gets.chomp.to_s)

puts "\n\nAinsi débutent les aventures de #{joueur.nom}, le héros légendaire\n\n"

1000.times do |tour|
	puts "\n------------------ Tour numéro #{tour + 1 } ------------------"

	Jeu.actions_possibles(monde, joueur)

	puts "\nQUELLE ACTION FAIRE ?"
	monde.choix = gets.chomp.to_i 

	if joueur.fureur >= 5
		if monde.choix == 0
			joueur.soin
		elsif monde.choix == 1
			joueur.ameliorer_degats
		elsif monde.choix == 2
			joueur.coup_circulaire(monde.ennemis)
		elsif monde.choix == 3
			puts "Choisir la cible: "
			i = 1
			monde.ennemis.each do |ennemi|
				puts "#{i} - Attaquer #{ennemi.info}"
				i = i + 1
			end
			monde.choix = gets.chomp.to_i
			ennemi_a_attaquer = monde.ennemis[monde.choix - 1]
			joueur.rafale(ennemi_a_attaquer)
		elsif monde.choix == 4
			joueur.charge
		elsif monde.choix == 99
			break
		elsif
			ennemi_a_attaquer = monde.ennemis[monde.choix - 5]
			joueur.attaque(ennemi_a_attaquer)
		else
			puts "Le manque d'adresse de #{joueur.nom} lui fait rater son action"
		end
	elsif joueur.fureur >= 3
		if monde.choix == 0
			joueur.soin
		elsif monde.choix == 1
			joueur.ameliorer_degats
		elsif monde.choix == 2
			joueur.coup_circulaire(monde.ennemis)
		elsif monde.choix == 3
			joueur.charge
		elsif monde.choix == 99
			break
		elsif
			ennemi_a_attaquer = monde.ennemis[monde.choix - 4]
			joueur.attaque(ennemi_a_attaquer)
		else
			puts "Le manque d'adresse de #{joueur.nom} lui fait rater son action"
		end
	else
		if monde.choix == 0
			joueur.soin
		elsif monde.choix == 1
			joueur.ameliorer_degats
		elsif monde.choix == 2
			joueur.charge
		elsif monde.choix == 99
			break
		elsif
			ennemi_a_attaquer = monde.ennemis[monde.choix - 3]
			joueur.attaque(ennemi_a_attaquer)
		else
			puts "Le manque d'adresse de #{joueur.nom} lui fait rater son action"
		end
	end

	puts "\nLES ENNEMIS RIPOSTENT !"
	monde.ennemis_en_vie.each do |ennemi|
		choix_ennemis = rand(1..3)
		if choix_ennemis == 1
			ennemi.attaque(joueur)
		elsif choix_ennemis == 2
			puts "#{ennemi.nom} se prépare à bloquer la prochaine attaque"
			ennemi.blocage
		elsif choix_ennemis == 3
			ennemi.soin
		end	
	end

	puts "\n#{joueur.info}\n"

	break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"



if joueur.en_vie
	puts "Vous avez gagné !"
else
	puts "Vous avez perdu !"
end
