require 'pg'

class Roles

  attr_accessor(:role_id, :role_name)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.all
    connection = self.open_connection

    sql = "SELECT * FROM roles"
    results = connection.exec(sql)
    roles = results.map do |role|
      self.hydrate(role)
    end
  end

  def self.find(role_id)
    connection = self.open_connection

    sql = "SELECT role_name FROM sparta_view WHERE role_id = #{role_id} LIMIT 1"
    role = connection.exec(sql)
    role = self.hydrate(role[0])
    role
  end


  def self.hydrate(role_data)
    role = Roles.new

    role.role_id = role_data['role_id']
    role.role_name = role_data['role_name']
    role
  end

  def save
    connection = Roles.open_connection

    if (!self.role_id)
      sql = "INSERT INTO roles(role_name) VALUES ('#{self.role_name}')"
    else
      sql = "UPDATE roles SET role_name='#{self.role_name}', WHERE id='#{self.role_id}'"
    end
    connection.exec(sql)
  end


  def self.destroy(role_id)
    connection = self.open_connection
    sql = "DELETE FROM roles WHERE role_id = #{role_id}"
    connection.exec(sql)
  end


end
