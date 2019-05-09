require 'pg'

class Specs

  attr_accessor(:spec_id, :spec_name)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.find(spec_id)
    connection = self.open_connection

    sql = "SELECT spec_name, spec_id FROM sparta_view WHERE spec_id = #{spec_id} LIMIT 1"
    spec = connection.exec(sql)
    spec = self.hydrate(spec[0])
    spec
  end


  def self.all
    connection = self.open_connection

<<<<<<< HEAD
    sql = "SELECT spec_name, spec_id FROM sparta_view GROUP BY spec_name"
    results = connection.exec(sql)
    specs = results.map do |spec|
    self.hydrate(spec)
    end
    
=======
    sql = "SELECT * FROM spec"
    results = connection.exec(sql)
    specs = results.map do |spec|
      self.hydrate(spec)
    end
>>>>>>> 675a01ae518bd1393271f5c4a2ed04056a705fb1
  end

  def self.hydrate(spec_data)
    spec = Spec.new

    spec.spec_id = spec_data[:spec_id]
    spec.spec_name = spec_data[:spec_name]
    spec
  end


  def save
    connection = Spec.open_connection

    if (!self.spec_id)
      sql = "INSERT INTO spec(spec_name) VALUES ('#{self.spec_name}')"
    else
      sql = "UPDATE spec SET spec_name='#{self.spec_name}', WHERE id='#{self.spec_id}'"
    end
    connection.exec(sql)
  end

  def self.destroy(spec_id)
    connection = self.open_connection
    sql = "DELETE FROM spec WHERE spec_id = #{spec_id}"
    connection.exec(sql)
  end


end
