Guide CRUD Ruby on Rails avec SQLite3
Introduction
Ce guide vous montre comment créer une application CRUD simple en utilisant Ruby on Rails avec SQLite3 comme base de données. Ce projet est idéal pour comprendre les principes de base de Rails, y compris le système MVC (Modèle-Vue-Contrôleur), les migrations, les routes, les vues, et les contrôleurs.

Prérequis
Ruby
Rails
SQLite3
Assurez-vous que Ruby, Rails, et SQLite3 sont installés sur votre machine. Vous pouvez vérifier les installations avec les commandes ruby -v, rails -v, et sqlite3 --version.

Étape 1: Création de l'Application
1.1 Créer une Nouvelle Application Rails
Dans votre terminal, exécutez :

bash
Copy code
rails new blog_app
Cette commande crée une nouvelle application Rails nommée `

blog_app` avec SQLite3 comme base de données par défaut.

1.2 Naviguer dans le Répertoire de l'Application
bash
Copy code
cd blog_app
Étape 2: Création du Modèle Article
2.1 Générer le Modèle
Exécutez :

bash
Copy code
rails generate model Article title:string content:text
Cela crée un modèle Article avec deux attributs : title et content.

2.2 Migrer la Base de Données
Effectuez la migration pour créer la table articles dans la base de données :

bash
Copy code
rails db:migrate
Étape 3: Création du Contrôleur Articles
3.1 Générer le Contrôleur
bash
Copy code
rails generate controller Articles
Cela crée un contrôleur Articles pour gérer les actions liées aux articles.

Étape 4: Définition des Routes
4.1 Configurer les Routes
Ouvrez config/routes.rb et ajoutez :

ruby
Copy code
resources :articles
Cela définit les routes pour toutes les actions CRUD standard pour les articles.

Étape 5: Mise en Place des Actions CRUD dans le Contrôleur
5.1 Éditer le Contrôleur Articles
Ouvrez app/controllers/articles_controller.rb et ajoutez les méthodes suivantes :

ruby
Copy code
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
Étape 6: Création des Vues
6.1 Créer les Vues pour les Actions CRUD
Pour chaque action (index, show, `new

, edit), vous devez créer un fichier de vue correspondant dans app/views/articles`.

6.2 Exemple pour new.html.erb
erb
Copy code
<h1>New Article</h1>

<%= form_with model: @article, local: true do |form| %>
  <% if @article.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>
      <ul>
      <% @article.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <p>
    <%= form.label :title %><br>
    <%= form.text_field :title %>
  </p>

  <p>
    <%= form.label :content %><br>
    <%= form.text_area :content %>
  </p>

  <p>
    <%= form.submit %>
  </p>
<% end %>
Répétez un processus similaire pour créer les vues index.html.erb, show.html.erb, et edit.html.erb.

Étape 7: Tester l'Application
7.1 Lancer le Serveur Rails
Dans votre terminal, exécutez :

bash
Copy code
rails server
7.2 Accéder à l'Application
Ouvrez un navigateur et allez à http://localhost:3000/articles pour voir votre application en action.