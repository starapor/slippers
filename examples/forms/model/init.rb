# Here goes your database connection and options:
require 'sequel'
Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('forms.db')

# Here go your requires for models:
# require 'model/user'
require 'model/orm/registration'
require 'model/registration_form_builder'
require 'model/registration_repository'
require 'model/registration_validator'
require 'model/registration_rules/required_field'
require 'model/registration_rules/number_field'
require 'model/registration_rules/incorrect_email_format'
require 'model/form'
require 'model/field'
require 'model/core_extensions/string_extensions'

