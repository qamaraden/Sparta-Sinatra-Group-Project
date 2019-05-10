class Login

  attr_accessor(:id, :email, :password_hash, :password_salt)

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

  def self.find(email)
    connection = self.open_connection
    sql = "SELECT email, password_hash, password_salt FROM sparta_view where email = '#{email}' LIMIT 1"
    emails = connection.exec(sql)
    email = self.hydrate(emails[0])
    email
  end


  def self.hydrate(post_data)
    email = Login.new
    email.id = post_data['id']
    email.email = post_data['email']
    email.password_hash = post_data['password_hash']
    email.password_salt = post_data['password_salt']
    email
  end

  def self.all
    connection = self.open_connection
    sql = "SELECT * FROM password"
    results = connection.exec(sql)
    emails = results.map do |email|
      self.hydrate(email)
    end
    emails
  end

  def save
  connection = Login.open_connection
    sql = "INSERT INTO password (email, password_hash, password_salt) VALUES ('#{self.email}','#{self.password_hash}', '#{self.password_salt}')"
  connection.exec(sql)
  end


end
