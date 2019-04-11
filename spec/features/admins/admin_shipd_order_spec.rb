require 'rails_helper'
RSpec.describe 'admin user index' do
  context 'as an admin' do
      it 'changes the staus of an order to shipped' do
        admin = create(:admin)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        order_1 = create(:order)
        order_2 = create(:order)
        item_1 , item_2 , item_3 , item_4 = create_list(:item, 4, user:merchant_1)
        item_5, item_6 , item_7 , item_8 = create_list(:item, 4, user:merchant_2)
        oi_1 = create(:order_item, item: item_1, order: order_1)
        oi_2 = create(:order_item, item: item_2, order: order_1)
        oi_5 = create(:order_item, item: item_5, order: order_1)
        oi_6 = create(:order_item, item: item_6, order: order_1)
        oi_3 = create(:order_item, item: item_3, order: order_2)
        oi_4 = create(:order_item, item: item_4, order: order_2)
        oi_7 = create(:order_item, item: item_7, order: order_2)
        oi_8 = create(:order_item, item: item_8, order: order_2)

        visit login_path
        fill_in "email", with: admin.email
        fill_in "password", with: admin.password
        click_button "Log In"
        click_on "Dashboard"
        expect(current_path).to eq(admin_dashboard_path(admin))

        within "#order-#{order_1.id}" do
          click_on 'Shipped'
        end

        expect(current_path.to eq(admin_dashboard_path))
        expect(page).to_not have_css("#order-#{order_1.id}")
        expect(order_1.status).to eq('shipped')
      end
  end
end
