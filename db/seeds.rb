# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if CmsPage.count == 0
  CmsPage.create([
                     {:id => 1, :name => 'About Us', :content => 'About Us', :meta_title => 'About Us', :seo_url => 'about_us', :meta_desc => 'About Us', :meta_keyword => 'About Us', :status => true},
                     {:id => 2, :name => 'Legal And Privacy', :content => 'Legal And Privacy', :meta_title => 'Legal And Privacy', :seo_url => 'legal_and_privacy', :meta_desc => 'Legal And Privacy', :meta_keyword => 'Legal And Privacy', :status => true},
                     {:id => 3, :name => 'FAQs', :content => 'FAQs', :meta_title => 'FAQs', :seo_url => 'faqs', :meta_desc => 'FAQs', :meta_keyword => 'FAQs', :status => true},
                     {:id => 4, :name => 'Terms And Conditions', :content => 'Terms And Conditions', :meta_title => 'Terms And Conditions', :seo_url => 'terms_and_conditions', :meta_desc => 'Terms And Conditions', :meta_keyword => 'Terms And Conditions', :status => true},
                 ])

end
if University.count == 0
  University.create([{:id => 1, :name => 'Zapbuild', :address => "Phase 8b Mohali", :phone => "1234567890", :city=>"Mohali", :state=>"Punjab", :zip => "12345", :billing_address => "Phase 8b Mohali" }])
end
if Admin.count == 0
  Admin.create([{:id => 1, :email => 'admin@example.com', :password => "123456", :full_name => "admin" }])
end

