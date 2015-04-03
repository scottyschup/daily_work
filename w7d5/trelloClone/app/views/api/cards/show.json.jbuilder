json.(@card, :title, :list_id, :description, :ord, :updated_at)
json.items @card.items do |item|
  json.(item, :title, :card_id, :done, :updated_at)
end
