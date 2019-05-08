require 'pg'

class Users

  attr_accessor(:userId, :firstName, :lastName, :email, :password, :cohortId, :roleId)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.all
    connection = self.open_connection

    sql = "SELECT firstName, lastName, email, password, cohortName, specName, roleName FROM sparta_view"

    results = connection.exec(sql)

    users = results.map do |user|
      self.hyrdate(user)
    end

    users
  end

  def self.find(userId)
    connection = self.open_connection

    sql = "SELECT firstName, lastName, email, password, cohortName, specName, roleName FROM sparta_view WHERE userId = #{userId} LIMIT 1;"

    users = connection.exec(sql)

    user = self.hydrate(users[0])

    user
  end

  def self.hyrdate(user_data)
    user = Users.new

    user.firstName = user_date['firstName']
    user.lastName = user_data['lastName']
    user.email = user_data['email']
    user.password = user_data['password']
    user.cohortId = Cohorts.get_id(user_data['cohortName'])
    user.roleId = Role.get_id(user_data['roleName'])

    user
  end

  def save
    connection = Users.open_connection

    if !self.userId
      sql = "INSERT INTO users (firstName, lastName, email, password, cohortId, roleId) VALUES ('#{self.firstName}', '#{self.lastName}', #{self.email}, '#{self.password}', '#{self.cohortId}' , #{self.roleId})"

    else

      sql = "UPDATE users SET firstName = '#{self.firstName}', last_name = '#{self.lastName}', age = #{self.email}, position = '#{self.password}', image = '#{self.cohortId}', team_id = #{self.roleId} WHERE id = #{self.userId}"
    end

    connection.exec(sql)
  end

  def self.destroy(userId)
    connection = self.open_connection

    sql = "DELETE FROM users WHERE userId = #{userId}"

    connection.exec(sql)
  end
end
