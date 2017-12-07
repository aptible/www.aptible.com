require 'spec_helper'

describe 'customer helpers' do
  include CustomerHelpers

  before do
    @customers = [
      OpenStruct.new(
        name: 'Customer1',
        slug: 'customer1',
        include_in_logo_bar: true,
        quotes: [OpenStruct.new(
          quote: 'Aptible is AWESOME',
          type: 'quote',
          approved: true,
          author: 'Happy Customer',
          position: 'Director of Keeping It Real',
          card_image: 'logo.svg',
          author_image: 'avatar.png'
        ), OpenStruct.new(
          quote: 'A+++++!',
          type: 'quote',
          approved: true,
          author: 'Happy Customer 2',
          position: 'CTO',
          card_image: 'logo.svg',
          author_image: 'avatar.png'
        )],
        case_study: {},
        logo: 'logo.svg'
      ),
      OpenStruct.new(
        name: 'Customer2',
        slug: 'customer2',
        include_in_logo_bar: true,
        quotes: [],
        case_study: OpenStruct.new(
          title: 'Case study title',
          summary: 'Summary',
          type: 'case_study',
          approved: true,
          path: '/customers/customer2/',
          card_image: 'image.png'
        ),
        logo: 'logo.svg'
      ),
      OpenStruct.new(
        name: 'Customer3',
        slug: 'customer3',
        include_in_logo_bar: true,
        quotes: [OpenStruct.new(
          quote: 'Aptible is AWESOME',
          type: 'quote',
          approved: true,
          author: 'Happy Customer',
          position: 'Director of Keeping It Real',
          card_image: 'logo.svg',
          author_image: 'avatar.png'
        )],
        case_study: OpenStruct.new(
          title: 'Case study title',
          summary: 'Summary',
          type: 'case_study',
          approved: true,
          path: '/customers/customer2/',
          card_image: 'image.png'
        ),
        logo: 'logo.svg'
      )
    ]
  end

  describe '#customer_cards' do
    it 'returns customer quotes and case studies' do
      cards = customer_cards(@customers)
      expect(cards.count).to equal 5
      expect(cards[0][:type] == 'quote')
      expect(cards[2][:type] == 'case_study')
    end
  end

  describe '#customer_cards_grouped_3col' do
    it 'returns customer cards in three separate arrays' do
      card_columns = customer_cards_grouped_3col(@customers)
      expect(card_columns.count == 3)
      expect(card_columns[0].count == 2)
      expect(card_columns[1].count == 2)
      expect(card_columns[2].count == 1)
    end
  end

  describe '#customers_for_logo_bar' do
    it 'returns no customers if an image file is not available' do
      customers = customers_for_logo_bar(@customers)
      expect(customers.empty?)
    end
  end
end
