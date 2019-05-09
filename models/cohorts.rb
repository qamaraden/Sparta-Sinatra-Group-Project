require 'pg'

class Cohorts

  attr_accessor(:first_name, :last_name, :user_id, :cohort_id, :cohort_name, :spec_id, :spec_name)

  def self.open_connection
    connection = PG.connect(dbname: 'sparta_db')
  end


  def self.find(cohort_id)
    connection = self.open_connection
    sql = "SELECT cohort_id, cohort_name, spec.spec_id, spec_name FROM cohorts INNER JOIN spec ON spec.spec_id = cohorts.spec_id WHERE cohort_id = #{cohort_id} LIMIT 1"
    cohorts = connection.exec(sql)
    cohort = self.hydrate(cohorts[0])
    cohort
  end

  def self.find_users(cohort_id)
    connection = self.open_connection
    sql = "SELECT * FROM sparta_view WHERE cohort_id = #{cohort_id}"
    results = connection.exec(sql)
    users = results.map do |user|
      self.hydrate(user)

    end

  end



  def self.all
    connection = self.open_connection

    sql = "SELECT * FROM cohorts"
    results = connection.exec(sql)
    cohorts = results.map do |cohort|
      self.hydrate(cohort)

    end
  end

  def self.hydrate(cohort_data)
    cohort = Cohorts.new

    cohort.cohort_id = cohort_data['cohort_id']
    cohort.cohort_name = cohort_data['cohort_name']
    cohort.spec_name = cohort_data['spec_name']
    cohort.user_id = cohort_data['user_id']
    cohort.first_name = cohort_data['first_name']
    cohort.last_name = cohort_data['last_name']

    cohort
  end


  def save
    connection = Cohorts.open_connection

    if (!self.cohort_id)

      sql = "INSERT INTO cohorts(cohort_name, spec_id) VALUES ('#{self.cohort_name}', '#{self.spec_id}')"
    else
      sql = "UPDATE cohorts SET cohort_name='#{self.cohort_name}', spec_id='#{self.spec_id}' WHERE id='#{self.cohort_id}'"
    end
    connection.exec(sql)
  end


  def self.destroy(cohort_id)
    connection = self.open_connection
    sql = "DELETE FROM cohorts WHERE cohort_id = #{cohort_id}"
    connection.exec(sql)
  end

end
