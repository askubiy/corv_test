class Validation
  def initialize(request_body)
    @request_body = request_body
    @errors = []
  end

  def validate_req_data
    validate_json
  end

  def validate_json
    begin
      JSON.parse(@request_body)
    rescue JSON::ParserError => e
      @errors << "JSON parse error"
    end
  end

  def formatted_errors
    @errors.join(" | ")
  end

  def valid?
    @errors.count == 0
  end
end
