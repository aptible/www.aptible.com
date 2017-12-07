module CustomerHelpers
  def customers_for_logo_bar(customers = data.customers.customers)
    customers.select do |customer|
      customer.include_in_logo_bar &&
        File.exist?("source/images/customers/#{customer.slug}.svg")
    end
  end

  def customer_cards(customers = data.customers.customers)
    cards = []
    customers.each do |customer|
      if customer.case_study.present?
        cards << {
          type: 'case_study',
          image: customer.case_study.card_image || '',
          title: customer.case_study.title,
          summary: customer.case_study.summary,
          path: customer.case_study.path
        }
      end
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
    cards
  end

  def customer_cards_grouped_3col(customers = data.customers.customers)
    cards = customer_cards(customers)
    card_count = cards.count
    group_size = card_count / 3
    group_size += 1 if card_count % 3 > 0
    cards.each_slice(group_size).to_a
  end
end
