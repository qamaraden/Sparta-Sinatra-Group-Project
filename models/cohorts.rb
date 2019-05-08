require 'pg'

class Cohorts

  attr_accessor(:cohort_id, :cohort_name, :spec_id)

  def self.open_connection
    connection = PG.connect(dbname: 'sparta_db')
  end


  def self.find(cohort_id)
    connection = self.open_connection

    sql = "SELECT cohort_id, cohort_name, spec_name FROM sparta_view WHERE cohort_id = #{cohort_id} LIMIT 1"
    cohort = connection.exec(sql)
    cohort = self.hydrate(cohort[0])
    cohort
  end


  # sql = "INSERT INTO Cohorts (cohort_name) VALUES ( SELECT #{cohort_name}"

  def self.all
    connection = self.open_connection

    sql = "SELECT cohort_name, cohort_id FROM sparta_view GROUP BY cohort_name"
    results = connection.exec(sql)
    cohorts = results.map do |cohort|
    self.hydrate(cohort)
    end
  end



  def self.hydrate(cohort_data)
    cohort = Cohorts.new

    cohort.cohort_id = cohort_data[:cohort_id]
    cohort.cohort_name = cohort_data[:cohort_name]
    cohort.spec_id = Specs.get_id(cohort_data[:spec_id])
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
