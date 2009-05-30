class Registration < Sequel::Model
  set_schema do
    primary_key :id

    varchar :name
    varchar :address
    varchar :email
  end

  create_table unless table_exists?

end