module Ckeditor
  class Asset < ActiveRecord::Base # :nodoc:
    include Ckeditor::Orm::ActiveRecord::AssetBase

    delegate :url, :current_path, :content_type, to: :data

    validates_presence_of :data
  end
end
