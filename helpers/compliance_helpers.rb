module ComplianceHelpers
  def load_hipaa_regulation
    data.hipaa.precalculated[regulation_slug]
  end

  def load_gdpr_regulation
    data.gdpr.precalculated[regulation_slug]
  end

  def regulation_slug
    current_page.destination_path.split('/')[-2]
  end
end
