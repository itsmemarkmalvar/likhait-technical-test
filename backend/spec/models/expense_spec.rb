require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create!(name: "Food") }

  describe "date validation" do
    it "allows today's date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 10.00,
        category: category,
        date: Date.current
      )
      expect(expense).to be_valid
    end

    it "allows past date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 10.00,
        category: category,
        date: 1.day.ago
      )
      expect(expense).to be_valid
    end

    it "rejects future date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 10.00,
        category: category,
        date: 1.day.from_now
      )
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("cannot be in the future")
    end
  end
end
