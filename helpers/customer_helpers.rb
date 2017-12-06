module CustomerHelpers
  def customers_for_logo_bar
    data.customers.customers.select do |customer|
      customer.include_in_logo_bar
    end
  end

  def customer_cards
    cards = []
    data.customers.customers.each do |customer|
      if customer.case_study.present?
        cards << {
          type: 'case_study',
          image: customer.case_study.card_image || '',
          title: customer.case_study.title,
          summary: customer.case_study.summary,
          path: customer.case_study.path
        }
      end
      if customer.quotes.present?
        customer.quotes.each do |quote|
          cards << {
            type: 'quote',
            image: customer.logo || '',
            quote: quote.quote,
            author: quote.author,
            author_position: "#{quote.position} at #{customer.name}",
            author_image: quote.author_image || ''
          }
        end
      end
    end
    cards
  end

  def customer_cards_grouped_3col
    cards = customer_cards + customer_cards.shuffle + customer_cards.shuffle
    card_count = cards.count
    group_size = card_count / 3
    group_size = group_size + 1 if card_count % 3 > 0
    cards.each_slice(group_size).to_a
  end
end
