require 'rails_helper'

RSpec.feature "Visitor adds an item to the cart", type: :feature, js: true do
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

  scenario "They see the cart increase by 1" do
    # ACT
    visit root_path
    # find("a.btn[href='/products/10']").click
      first('.button_to').click_button("Add")
    
    # DEBUG
    save_screenshot
    
    # VERIFY
    expect(page).to have_link 'My Cart (1)', href: '/cart'
  end
end
