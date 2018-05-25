module ResourceHelpers
  def webinars(webinar_slug)
    section_pages('Resources')
      .select { |r| r.data.type == 'webinar' && r.data.slug != webinar_slug }
      .sort_by { |r| -r.data.created_at.to_time.to_i }
  end

  def featured_resource
    section_pages('Resources')
      .select { |r| r.data.featured }.first
  end

  def resource_header_style(resource)
    if resource.data.cover_image.present?
      "background-image: url(#{resource.data.cover_image.url});"
    else
      ''
    end
  end

  def resources_for_footer
    section_pages('Resources')
      .select { |p| p.data['included_in_footer'] }
      .sort_by { |p| p.data['footer_position'] }
  end

  def resources_for_index
    section_pages('Resources')
      .select { |p| p.data['included_on_index'] }
      .sort_by { |p| -p.data['created_at'].to_time.to_i }
  end

  def resources_by_category(category)
    resources_for_index.select { |p| p.data.category == category }
  end

  def enclave_resources
    resources_by_category 'Enclave'
  end

  def gridiron_resources
    resources_by_category 'Gridiron'
  end

  def hipaa_resources
    resources_by_category 'HIPAA'
  end

  def aptible_update_resources
    resources_by_category 'Aptible Updates'
  end

  def webinar_resources
    resources_by_category 'Webinars'
  end

  def resource_path(resource)
    return if resource.nil?
    data = resource.data
    path = "/#{data.slug}/"
    path = "/#{data.subfolder}#{path}" if data.subfolder.present?
    path
  end

  def document_file_extension(path)
    File.extname(path).delete('.')
  end
end
