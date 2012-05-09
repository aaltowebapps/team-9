When /^I visit "([^\"]*)"$/ do |page_name|
  visit(page_name)
end

Given /^the following weather stations exist:$/ do |table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:weather_station, attributes)
  end
end