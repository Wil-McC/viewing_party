FactoryBot.define do
  factory :friendship do
    user
  end
end


#
# create_table "friendships", force: :cascade do |t|
#   t.bigint "user_id"
#   t.bigint "friend_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["friend_id"], name: "index_friendships_on_friend_id"
#   t.index ["user_id"], name: "index_friendships_on_user_id"
