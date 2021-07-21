class ChangeReviewTextConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reviews, :text, false
  end
end
