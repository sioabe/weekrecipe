class AddRakutenScrapingToStorages < ActiveRecord::Migration[5.0]
  def change
    add_reference :storages, :rakuten_scraping, foreign_key: true
  end
end
