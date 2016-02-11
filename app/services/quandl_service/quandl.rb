module QuandlService::Quandl # :nodoc:
  module_function

  def get_quandl_data(company_id, row)
    company = Company.find(company_id)
    token = Rails.application.secrets.quandl_token
    url = Rails.application.secrets.quandl_url
    HTTParty.get("#{url}#{company.free_code}.json?api_key=#{token}&rows=#{row}")
  end
end
