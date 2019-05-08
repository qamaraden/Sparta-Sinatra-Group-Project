class Roles

  attr_accessor(:roleId, :roleName)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.find(roleId)
    connection = self.open_connection

    sql = "SELECT roleName FROM sparta_view WHERE roleId = #{roleId} LIMIT 1"
    role = connection.exec(sql)
    role = self.hydrate(role[0])
    role
  end


  def self.hydrate(role_data)
    role = Role.new

    role.roleId = role_data[:roleId]
    role.roleName = role_data[:roleName]
    role
  end

  def save
    connection = Role.open_connection

    if (!self.roleId)
      sql = "INSERT INTO roles(roleName) VALUES ('#{self.roleName}'"
    else
      sql = "UPDATE roles SET roleName='#{self.roleName}', WHERE id='#{self.roleId}'"
    end
    connection.exec(sql)
  end


  def self.destroy(roleId)
    connection = self.open_connection
    sql = "DELETE FROM roles WHERE roleId = #{roleId}"
    connection.exec(sql)
  end


end
