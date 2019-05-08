class Login

  attr_accessor(:id, :email, :password_hash, :password_salt)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end


  def self.find(email)
    connection = self.open_connection
    sql = " SELECT email FROM password WHERE email = #{email}"
    emails = connection.exec(sql)
    email = self.hydrate(posts[0])
    email
  end

  def self.hydrate(email_data)
    email = Login.new
    email.id = email_data['id']
    email.email = email_data['email']
    email.password_hash = email_data['password_hash']
    email.password_salt = email_data['password_salt']
    email
    puts email.email
  end

  def self.all
    connection = self.open_connection
    sql = "SELECT * from password"
    results = connection.exec(sql)
    emails = results.map do |email|
      self.hydrate(email)
    end
    emails
  end


  def signup
  connection = Login.open_connection
    sql = "INSERT INTO password (email, password_hash, password_salt) VALUES ('#{self.email}','#{self.password_hash}', '#{self.password_salt}')"
  connection.exec(sql)
  end

end
