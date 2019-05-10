require 'pg'

class Users

  attr_accessor(:user_id, :first_name, :last_name, :email, :password, :password_salt, :password_hash, :cohort_id, :cohort_name, :role_id, :role_name, :spec_id, :spec_name)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.all
    connection = self.open_connection

    sql = "SELECT * FROM sparta_view"

    results = connection.exec(sql)

    users = results.map do |user|
      self.hydrate(user)
    end

    users
  end

  def self.find(user_id)
    connection = self.open_connection

    sql = "SELECT * FROM sparta_view WHERE user_id = #{user_id} LIMIT 1;"

    users = connection.exec(sql)

    user = self.hydrate(users[0])

    user
  end

  def self.hydrate(user_data)
    user = Users.new

    user.user_id = user_data['user_id']
    user.first_name = user_data['first_name']
    user.last_name = user_data['last_name']
    user.email = user_data['email']
    user.password = user_data['password']
    user.password_hash = user_data['passowrd_salt']
    user.password_salt = user_data['passowrd_hash']
    user.cohort_id = user_data['cohort_id']
    user.spec_id = user_data['spec_id']
    user.spec_name = user_data['spec_name']
    user.role_id = user_data['role_id']
    user.cohort_name = user_data['cohort_name']
    user.role_name = user_data['role_name']

    user
  end

  def save
    connection = Users.open_connection

    if !self.user_id
      sql = "INSERT INTO users (first_name, last_name, email, password_hash, password_salt, cohort_id, role_id) VALUES ('#{self.first_name}', '#{self.last_name}', '#{self.email}', '#{self.password_hash}', '#{self.password_salt}', #{self.cohort_id}, #{self.role_id})"

    else

      sql = "UPDATE users SET first_name = '#{self.first_name}', last_name = '#{self.last_name}', email = '#{self.email}', password_hash = '#{self.password_hash}', password_salt = '#{self.password_salt}', cohort_id = #{self.cohort_id}, role_id = #{self.role_id} WHERE user_id = #{self.user_id}"
    end

    connection.exec(sql)
  end

  def self.destroy(user_id)
    connection = self.open_connection

    sql = "DELETE FROM users WHERE user_id = #{user_id}"

    connection.exec(sql)
  end
end
