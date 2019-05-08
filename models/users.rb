require 'pg'

class Users

  attr_accessor(:userId, :firstName, :lastName, :email, :password, :cohortId, :roleId)

  def self.open_connection

    connection = PG.connect(dbname: '')

  end

  def self.all

    connection = self.open_connection

    sql = "SELECT "
  end
end
