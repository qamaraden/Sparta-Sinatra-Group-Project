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

  def self.hydrate(post_data) #Returns post object with the values (ID, title, body)
    email = Login.new
    email.id = post_data['id']
    email.email = post_data['email']
    email.password_hash = post_data['password_hash']
    email.password_salt = post_data['password_salt']
    email
  end

  #Method to get all the blog posts
  def self.all
    connection = self.open_connection #Use method created above
    sql = "SELECT email FROM password"
    #PG Object is results
    results = connection.exec(sql)
    #Return an array of post object (results)
    emails = results.map do |email| #MAP creates an array of posts
      self.hydrate(email)
    end
    emails
  end

  def save
  connection = Login.open_connection
    sql = "INSERT INTO password (email, password_hash, password_salt) VALUES ('#{self.email}','#{self.password_hash}', '#{self.password_salt}')"
  connection.exec(sql)
  end


  def self.find(email) #Pass ID
  connection = self.open_connection
  sql = "SELECT * FROM password WHERE email = '#{email}' LIMIT 1" #Only return 1 (returns as an array)
  emails = connection.exec(sql)
  # email = self.hydrate(emails[0])
  email
end
end
