# frozen_string_literal: true

class AddDateToExpenses < ActiveRecord::Migration[7.2]
  def up
    return unless table_exists?(:expenses)

    unless column_exists?(:expenses, :date)
      add_column :expenses, :date, :date, null: true
      execute "UPDATE expenses SET date = DATE(created_at) WHERE date IS NULL"
      change_column_null :expenses, :date, false
    end

    remove_column :expenses, :payer_name if column_exists?(:expenses, :payer_name)
  end

  def down
    return unless table_exists?(:expenses)

    if column_exists?(:expenses, :date) && !column_exists?(:expenses, :payer_name)
      add_column :expenses, :payer_name, :string, limit: 100, null: false, default: "Unknown"
    end
    remove_column :expenses, :date if column_exists?(:expenses, :date)
  end
end
