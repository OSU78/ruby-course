class CrudManager
  def initialize(model)
    @model = model
  end

  def new
    # Pour créer une nouvelle instance de Game
    @model.new
  end
  
  def find(id)
    # Pour trouver une instance spécifique de Game en utilisant son ID
    @model.find(id)
  end


  def index
    # Logique pour récupérer tous les enregistrements depuis la base de données
    @model.all
  end

  def create(params)
    # Logique pour créer un nouvel enregistrement dans la base de données avec les paramètres fournis
    @model.create(params)
  end


  def update(id, params)
    # Logique pour mettre à jour un enregistrement existant dans la base de données avec les paramètres fournis
    object = @model.find(id)
    object.update(params)
  end
  
  
  def destroy(id)
    # Logique pour supprimer un enregistrement de la base de données en utilisant l'ID fourni
    @model.destroy(id)
  end
end