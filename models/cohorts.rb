require 'pg'

class Cohorts

  attr_accessor(:cohert_id, :cohert_name, :spec_id)

  def self.open_connection
    connection = PG.connect(dbname: 'sparta_db')
  end


  def self.find(cohert_id)
    connection = self.open_connection

    sql = "SELECT cohert_name, specName FROM sparta_view WHERE cohert_id = #{cohert_id} LIMIT 1"
    cohort = connection.exec(sql)
    cohort = self.hydrate(cohort[0])
    cohort
  end


  def self.all
    connection = self.open_connection

    sql = "SELECT cohert_name FROM sparta_view GROUP BY cohert_name"
    results = connection.exec(sql)
    cohorts = results.map do |cohort|
    self.hydrate(cohort)
  end


  def self.hydrate(cohort_data)
    cohort = Cohorts.new

    cohort.cohert_id = cohort_data[:cohert_id]
    cohort.cohert_name = cohort_data[:cohert_name]
    cohort.spec_id = Specs.get_id(cohort_data[:spec_id])
    cohort
  end


  def save
    connection = Cohorts.open_connection

    if (!self.cohert_id)
      sql = "INSERT INTO cohorts(cohert_name, spec_id) VALUES ('#{self.cohert_name}', '#{self.spec_id}')"
    else
      sql = "UPDATE cohorts SET cohert_name='#{self.cohert_name}', spec_id='#{self.spec_id}' WHERE id='#{self.cohert_id}'"
    end
    connection.exec(sql)
  end


  def self.destroy(cohert_id)
    connection = self.open_connection
    sql = "DELETE FROM cohorts WHERE cohert_id = #{cohert_id}"
    connection.exec(sql)
  end

end
