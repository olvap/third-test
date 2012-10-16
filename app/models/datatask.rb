require 'couchbase/model'

class Datatask < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :created_at, :default => lambda{ Time.zone.now }
  
  def save
    super
  end
  
end
