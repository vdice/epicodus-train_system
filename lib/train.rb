class Train
  attr_reader(:id, :eta, :city_id)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @eta = attributes.fetch(:eta)
    @city_id = attributes.fetch(:city_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (eta, city_id) VALUES ('#{@eta}', #{@city_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
end
