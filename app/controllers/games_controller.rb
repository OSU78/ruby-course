# Inclusion de CrudManager, qui gère les opérations de base de données pour les jeux.
require_relative '../services/crud_manager'

# GamesController hérite d'ApplicationController et gère les actions liées aux jeux.
class GamesController < ApplicationController
  # Définit @game pour les actions show, edit, update, et destroy pour éviter la répétition du code.
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # Index : récupère tous les jeux et initialise une nouvelle instance de jeu pour les formulaires.
  def index
    @games = crud_manager.index
    @game = crud_manager.new
  end

  # Show : affiche un jeu spécifique.
  def show
  end

  # New : initialise une nouvelle instance de jeu pour le formulaire d'ajout.
  def new
    @game = crud_manager.new
  end

  # Edit : prépare le formulaire d'édition d'un jeu spécifique.
  def edit
  end

  # Create : tente de sauvegarder un nouveau jeu et gère la redirection ou l'affichage d'erreurs.
  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # Update : met à jour un jeu existant et gère la redirection ou l'affichage d'erreurs.
  def update
    if crud_manager.update(@game.id, game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # Destroy : supprime un jeu et redirige vers la liste des jeux.
  def destroy
    crud_manager.destroy(@game.id)
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private

  # Définit @game en récupérant un jeu spécifique de la base de données.
  def set_game
    @game = crud_manager.find(params[:id])
  end

  # Sécurise les paramètres du formulaire pour éviter les injections indésirables.
  def game_params
    params.require(:game).permit(:name, :price, :banner, :username)
  end

  # Retourne une instance de CrudManager, utilisant le pattern Singleton.
  def crud_manager
    @crud_manager ||= CrudManager.new(Game)
  end
end
