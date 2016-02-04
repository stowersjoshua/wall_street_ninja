namespace :quandl_task do
  desc "Rake task to get events data"
  task update_price: :environment do
    companies = Company.all
    if companies.present?
      Company.all.each do |company|
        response = QuandlService::Quandl.get_quandl_data(company.id, 1)
        price = response["dataset"]["data"][0][4]
        company.update_attribute(:current_price, price)
      end
    end
  end
end