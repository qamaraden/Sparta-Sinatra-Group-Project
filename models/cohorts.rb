require 'pg'

class Cohorts

  attr_accessor(:cohortId, :cohortName, :specId)

  def self.open_connection
    connection = PG.connect(dbname: 'sparta_db')
  end


  def self.find(cohortId)
    connection = self.open_connection

    sql = "SELECT cohortName, specName FROM sparta_view WHERE cohortId = #{cohortId} LIMIT 1"
    cohort = connection.exec(sql)
    cohort = self.hydrate(cohort[0])
    cohort
  end


  def self.all
    connection = self.open_connection

    sql = "SELECT cohortname FROM sparta_view GROUP BY cohortName"
    results = connection.exec(sql)
    cohorts = results.map do |cohort|
    self.hydrate(cohort)
  end


  def self.hydrate(cohort_data)
    cohort = Cohorts.new

    cohort.cohortId = cohort_data[:cohortId]
    cohort.cohortName = cohort_data[:cohortName]
    cohort.specId = Specs.get_id(cohort_data[:spceId])
    cohort
  end


  def save
    connection = Cohorts.open_connection

    if (!self.cohortId)
      sql = "INSERT INTO cohorts(cohortName, specId) VALUES ('#{self.cohortName}', '#{self.specId}')"
    else
      sql = "UPDATE cohorts SET cohortName='#{self.cohortName}', specId='#{self.specId}' WHERE id='#{self.cohortId}'"
    end
    connection.exec(sql)
  end


  def self.destroy(cohortId)
    connection = self.open_connection
    sql = "DELETE FROM cohorts WHERE cohortId = #{cohortId}"
    connection.exec(sql)
  end

end
