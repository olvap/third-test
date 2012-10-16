require 'couchbase/model'

class Word < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
end
