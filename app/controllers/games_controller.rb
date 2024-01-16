# On inclut notre la class CRUD qui gère les opérations lier à notre base de données .
require_relative '../services/crud_manager'

# Définition de la classe GamesController qui hérite d'ApplicationController, 
# le contrôleur standard de Rails qui permet la gestion des jeux.
class GamesController < ApplicationController
  # before_action est un callback utilisé ici pour appeler la méthode set_game 
  # avant les actions show, edit, update et destroy, évitant ainsi de répéter le code. 
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # La fonction Index (appeler aussi une Action ) : récupère tous les jeux de la base de données et les stocke dans @games.
  # Elle initialise également un nouvelle instance de jeu vide avec @game pour les formulaires.
  def index
    @games = crud_manager.index
    @game = crud_manager.new
  end

  # l'Action show qui permet d'afficher un jeu spécifique.
  # Le jeu a déjà été préparé par le before_action set_game.
  def show
  end

  # Action new qui initialise un nouvelle instance de jeu vide avec @game pour le formulaire.
  def new
    @game = crud_manager.new
    # Une simple instruction de log pour afficher l'objet @game lors de sa création.
    puts "--x-LOGGG--@game dans new: #{@game.inspect}"
  end

  # Action edit, utilisée pour afficher le formulaire d'édition d'un jeu.
  # Le jeu est déjà préparé par le before_action set_game.
  def edit
  end

  # Action create qui tente de sauvegarder un nouveau jeu dans la base de données.
  def create
    # Crée une instance de jeu avec les paramètres obtenus du formulaire.
    @game = Game.new(game_params)

    # Si la sauvegarde est réussie, rediriger l'utilisateur vers la page de ce jeu
    # sinon, réafficher le formulaire pour corriger les erreurs.
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # Action update qui met à jour les attributs d'un jeu existant avec les paramètres reçus. 
  def update
    # Si la mise à jour est réussie, rediriger vers la page du jeu, 
    # sinon réafficher le formulaire avec les erreurs.
    if crud_manager.update(@game.id, game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # Action destroy qui supprime un jeu de la base de données.
  def destroy
    crud_manager.destroy(@game.id)
    # Après la suppression, redirige l'utilisateur vers l'indice/liste des jeux.
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private

  # Méthode privée qui définit l'objet @game en récupérant un jeu spécifique depuis la base de données.
  def set_game
    @game = crud_manager.find(params[:id])
  end

  # Méthode privée qui extrait les paramètres du formulaire et les filtre pour des raisons de sécurité.
  def game_params
    params.require(:game).permit(:name, :price, :banner)
  end

  # Méthode privée qui retourne une instance de CrudManager pour gérer les jeux.
  # Cette méthode utilise le pattern Singleton pour ne pas instancier CrudManager plusieurs fois.
  def crud_manager
    @crud_manager ||= CrudManager.new(Game)
  end
end
