class Specs

  attr_accessor(:specId, :specName)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.find(specId)
    connection = self.open_connection

    sql = "SELECT specName FROM sparta_view WHERE specId = #{specId} LIMIT 1"
    spec = connection.exec(sql)
    spec = self.hydrate(spec[0])
    spec
  end


  def self.all
    connection = self.open_connection

    sql = "SELECT specName FROM sparta_view GROUP BY spectName"
    results = connection.exec(sql)
    specs = results.map do |spec|
    self.hydrate(spec)
  end


  def self.hydrate(spec_data)
    spec = Spec.new

    spec.specId = spec_data[:specId]
    spec.specName = spec_data[:specName]
    spec
  end


  def save
    connection = Spec.open_connection

    if (!self.specId)
      sql = "INSERT INTO spec(specName) VALUES ('#{self.specName}'"
    else
      sql = "UPDATE spec SET specName='#{self.specName}', WHERE id='#{self.specId}'"
    end
    connection.exec(sql)
  end

  def self.destroy(specId)
    connection = self.open_connection
    sql = "DELETE FROM spec WHERE specId = #{specId}"
    connection.exec(sql)
  end


end
