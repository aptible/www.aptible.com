module ResourceHelpers
  def webinars(webinar_slug)
    section_pages('Resources')
      .select { |r| r.data.type == 'webinar' && r.data.slug != webinar_slug }
      .sort_by { |r| -r.data.created_at.to_time.to_i }
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
