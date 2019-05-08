class Specs

  attr_accessor( )

  def self.open_connection

    connection = PG.connect(dbname: 'sparta_db')

  end

end
