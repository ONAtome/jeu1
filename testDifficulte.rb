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

      def coup_circulaire(personnes)
        if energie < 3
          puts "Vous avez beau essayer, vous n'arrivez pas à réunir l'énergie nécessaire à cette attaque..."
        else
          puts "#{self.nom} fait un coup circulaire !"
          puts "#{self.nom} inflige #{30 + degats_bonus} points de dégâts à tous les ennemis"
          personnes.each do | personne |
          personne.subit_attaque(self.degats_circulaire)
          energie -= 3
          end
        end
        self.degats_circulaire
      end

  def subit_attaque(degats_recus)
    self.points_de_vie -= degats_recus
    puts "#{self.nom} prend #{degats_recus} degats et a maintenant #{self.points_de_vie} PV !"
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
  def self.actions_possibles(monde)
    puts "ACTIONS POSSIBLES :"

    puts "0 - Se soigner"
    puts "1 - Améliorer son attaque"
    puts "2 - Coup circulaire (Coût: 3 énergie)"
    i = 3
    monde.ennemis.each do |ennemi|
      puts "#{i} - Attaquer #{ennemi.info}"
      i = i + 1
    end
    puts "99 - Quitter"
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
  attr_accessor :ennemis
   def initialize 
        @ennemis = []
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
      attr_accessor :degats_bonus, :energie

      def initialize(nom)
        @degats_bonus = 0
        @energie = 0
        super(nom)
      end

      def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


      def degats
        degats = rand(20..30) + degats_bonus
        return degats
      end

      def degats_circulaire
        degats_circulaire = 30 + degats_bonus
        return degats_circulaire
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
      def degats
        degats = rand(1...5)
        return degats
      end
  end

elsif difficulte == 1

  class Joueur < Personne
    attr_accessor :degats_bonus

      def initialize(nom)
        @degats_bonus = 0
        super(nom)
      end

         def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


      def degats
        degats = rand(20..30) + degats_bonus
        return degats
    end

     def degats_circulaire
        degats_circulaire = 30 + degats_bonus
        return degats_circulaire
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
  end

elsif difficulte == 2

  class Joueur < Personne
      attr_accessor :degats_bonus

      def initialize(nom)
        @degats_bonus = 0
        super(nom)
      end

         def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


      def degats
        degats = rand(20..30) + degats_bonus
        return degats
      end

       def degats_circulaire
        degats_circulaire = 30 + degats_bonus
        return degats_circulaire
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
        degats = rand(10...15)
        return degats
      end
  end

elsif difficulte == 3

  class Joueur < Personne
      attr_accessor :degats_bonus

      def initialize(nom)
        @degats_bonus = 0
        super(nom)
      end

         def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


      def degats
        degats = rand(20..30) + degats_bonus
        return degats
      end

       def degats_circulaire
        degats_circulaire = 30 + degats_bonus
        return degats_circulaire
      end

      def soin
        soin = rand(20..30)
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
        degats = rand(15...20)
        return degats
      end
  end

elsif difficulte == 4

  class Joueur < Personne
      attr_accessor :degats_bonus

        def initialize(nom)
          @degats_bonus = 0
          super(nom)
      end

         def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


        def degats
          degats = rand(20..30) + degats_bonus
          return degats
        end

         def degats_circulaire
        degats_circulaire = 30 + degats_bonus
        return degats_circulaire
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
  end

elsif difficulte == 5

  class Joueur < Personne
      attr_accessor :degats_bonus

      def initialize(nom)
        @degats_bonus = 0
        super(nom)
      end

         def attaque(personne)
        degats_infliges = degats_inflige
        puts "#{self.nom} attaque #{personne.nom} !"
        puts "#{self.nom} inflige #{degats_infliges} points de dégâts"
        personne.subit_attaque(degats_infliges)
        self.degats_inflige
        @energie += 1
      end


      def degats
        degats = rand(1..100) + degats_bonus
        return degats
      end

       def degats_circulaire
        degats_circulaire = rand(1...100) + degats_bonus
        return degats_circulaire
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
  end

else
  puts "Choix invalide, fermeture du jeu."
end
##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Slime bleu"),
  Ennemi.new("Slime vert"),
  Ennemi.new("Slime rouge")
]



# Initialisation du joueur
puts "Comment vous appelez-vous, Aventurier ?"
joueur = Joueur.new(gets.chomp.to_s)

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}, le héros légendaire\n\n"

# Boucle de jeu principale
while true do |tour|
  puts "\n------------------ Tour numéro #{tour + 1 } ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 2
    joueur.coup_circulaire(monde.ennemis)
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    break
  elsif
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car les choix 0 et 1 étaient réservés pour le soin et
    # l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  else
    puts "Le manque d'adresse de #{joueur.nom} lui fait rater son action"
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\n#{joueur.info}\n"

  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"

# A faire:
# - Afficher le résultat de la partie

if joueur.en_vie
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end

#Pour bloquer l'attaque si pas assez d'énergie mettre un true/false qui bloque la possibilité
