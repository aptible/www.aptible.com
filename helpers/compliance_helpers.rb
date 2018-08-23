module ComplianceHelpers
  def load_protocol
    if current_page.url.start_with?('/hipaa/')
      data.hipaa
    elsif current_page.url.start_with?('/gdpr/')
      data.gdpr
    end
  end

  def load_regulation(protocol)
    protocol.precalculated[regulation_slug]
  end

  def regulation_slug
    current_page.destination_path.split('/')[-2]
  end
end
