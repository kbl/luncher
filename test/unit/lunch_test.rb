require 'test_helper'

class LunchTest < ActiveSupport::TestCase

  test "should save lunch without date" do
    lunch = Factory(:lunch, :date => nil)
    assert !lunch.new_record?, "Failed to save the lunch without a date"
  end

  test "should not save lunch without vendor" do
    lunch = Factory.build(:lunch, :vendor => nil)
    assert !lunch.save, "Saved the lunch without a vendor"
  end

  test "should not save lunch without name" do
    lunch = Factory.build(:lunch, :name => nil)
    assert !lunch.save, "Saved the lunch without a name"
  end

  test "should not save lunch without description" do
    lunch = Factory.build(:lunch, :description => nil)
    assert !lunch.save, "Saved the lunch without a description"
  end
  
  test "should save lunch without price" do
    lunch = Factory(:lunch, :price => nil)
    assert lunch.save, "Failed to save the lunch without a price"
  end
  
  test "should be refundable by default" do
    lunch = Factory(:lunch)
    assert lunch.refundable, "Lunch is not refundable by default"
  end

  test "should assign a default price for lunch without price" do
    lunch = Factory(:lunch)
    assert_equal 10, lunch.price, "Default price is incorrect"
  end

  test "should not increase the price when saving non-refundable lunch" do
    lunch = Factory(:lunch, :refundable => false)
    assert_equal 10, lunch.price, "Non-refunded price is incorrect"
  end

  test "should not save two lunches with the same name in one day" do
    lunch = Factory(:lunch)
    same_name = lunch.name

    assert lunch.valid?, "Validation should have been successful"

    lunch = Factory.build(:lunch, :name => same_name)
    assert !lunch.save, "Shouldn't have saved two lunches with the same name for one date"
  end

  test "should find at least one lunch without date" do
    lunch = Factory.build(:lunch, :date => nil)
    assert lunch.save
    lunches = Lunch.find_all_by_date_or_dateless('2010-04-01', true)
    lunches = lunches.select { |l| not l.date }
    assert !lunches.empty?, "Should have found at least one lunch!"
  end

  test "should find all by date without dateless" do
    5.times { Factory(:lunch, :date => '2010-09-09') }
    size_of_list = Lunch.find_all_by_date_or_dateless('2010-09-09').size
    assert_equal 5, size_of_list, "should find exactly 5 records"
  end

  test "should find all by date include dateless" do
    3.times { Factory(:lunch, :date => '2010-10-10') }
    3.times { assert Factory.build(:lunch, :date => nil).save }

    assert Lunch.find_all_by_date_or_dateless('2010-10-10', true).size >= 6, "Should have found at least 6 lunches"
  end

end


# == Schema Information
#
# Table name: lunches
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  price       :float           default(10.0)
#  created_at  :datetime
#  updated_at  :datetime
#  vendor_id   :integer
#  available   :boolean         default(TRUE)
#

