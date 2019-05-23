class Pokemon

  attr_accessor :id, :name, :type, :db

  def initialize(pokemon={})
    @id = pokemon['id']
    @name = pokemon['name']
    @type = pokemon['type']
    @db = db
  end

  def self.save(name, type, db)

      sql = "INSERT INTO pokemon (name, type) VALUES (?, ?);"
      db.execute(sql, name, type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.new_from_db(row)
    new_pokemon = self.new
    new_pokemon.id = row[0]
    new_pokemon.name = row[1]
    new_pokemon.type = row[2]
    new_pokemon

  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    db.execute(sql,id).map{|row|
      self.new_from_db(row)}[0]
  end
end
