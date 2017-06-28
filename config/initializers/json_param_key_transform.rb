ActionDispatch::Request.parameter_parsers[:json] = -> (raw_post) {
  data = ActiveSupport::JSON.decode(raw_post)
  data = {:_json => data} unless data.is_a?(Hash)

  # Transform camelCase param keys to snake_case:
  data.deep_transform_keys!(&:underscore)
}