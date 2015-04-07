# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

json.(@board, :title, :created_at, :updated_at)

json.lists @board.lists do |list|
  json.title list.title
  json.ord list.ord
  json.board_id list.board_id
  json.cards list.cards, :title, :list_id, :description, :ord, :updated_at
end
