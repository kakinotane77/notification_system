require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '入力フォームのテスト' do
    it '名前がないと無効である' do
      customer = FactoryBot.build(:customer, name: nil)
      expect(customer).not_to be_valid
    end

    it 'メールも電話番号もないと無効である' do
      customer = FactoryBot.build(:customer, email: nil, phone: nil)
      expect(customer).not_to be_valid
    end

    it 'メールがあれば有効である' do
      customer = FactoryBot.build(:customer, name: "テスト太郎", phone: nil, email: "test@example.com")
      expect(customer).to be_valid
    end

    it '電話番号があれば有効である' do
      customer = FactoryBot.build(:customer, name: "テスト太郎", phone: "09012345678", email: nil)
      expect(customer).to be_valid
    end
  end
end
