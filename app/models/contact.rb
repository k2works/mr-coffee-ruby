# frozen_string_literal: true

class Contact
  include Aws::Record

  integer_attr :id, hash_key: true
  string_attr :name, range_key: true
  string_attr :email
  string_attr :questionnaire
  string_attr :category
  string_attr :message
  epoch_time_attr :ts
end
