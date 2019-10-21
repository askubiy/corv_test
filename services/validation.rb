REQUIRED_PROPS = ['data', 'timestamp'].freeze

class Validation
  def initialize(request_body)
    @request_body = request_body
    @valid_values = []
    @errors = []
  end

  attr_reader :valid_values

  def validate_req_data
    validate_json
    return if !valid?
    validate_required_props
    return if !valid?
    validate_required_data
    return if !valid?
  end

  def validate_json
    begin
      @request_body = JSON.parse(@request_body)
    rescue StandardError => e
      @errors << 'JSON parse error'
    end
  end

  def validate_required_props
    REQUIRED_PROPS.each do |prop|
      @errors << "Missed required property: #{prop}" if @request_body[prop].nil?
    end
  end

  def validate_required_data
    item_1 = @request_body['data'].detect {|item| item["title"] == "Part 1"} rescue nil
    if item_1.nil?
      @errors << 'Missed Part 1 item in data'
      return
    end

    item_2 = @request_body['data'].detect {|item| item["title"] == "Part 2"} rescue nil
    if item_2.nil?
      @errors << 'Missed Part 2 item in data'
      return
    end

    values_1 = item_1['values'] rescue nil
    if values_1.nil?
      @errors << 'Missed Part 1 values in data'
      return
    end

    values_2 = item_2['values'] rescue nil
    if values_2.nil?
      @errors << 'Missed Part 2 values in data'
      return
    end

    if !values_1.kind_of?(Array) || !values_2.kind_of?(Array)
      @errors << 'Wrong type of values'
      return
    end

    if values_1.count != values_2.count
      @errors << 'Value arrays length mismatch'
      return
    end

    @valid_values = [values_1, values_2]
  end

  def formatted_errors
    @errors.join(' | ')
  end

  def valid?
    @errors.count == 0
  end
end
