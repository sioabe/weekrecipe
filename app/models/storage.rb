class Storage < ApplicationRecord
     belongs_to :recipe
     belongs_to :food
     belongs_to :rakuten_scraping
end
