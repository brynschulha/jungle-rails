require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
  
    9.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    1.times do |n|
      @category.products.create!(
        name:  "Shoes",
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click a product and see the products details" do
    # ACT
    visit root_path
    find("a.btn[href='/products/10']").click
    
    # DEBUG
    save_screenshot
    
    # VERIFY
    expect(page).to have_css 'section.products-show'
  end
end
