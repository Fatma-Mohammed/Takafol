namespace :monthly do
  desc "TODO"
  task changeNeeded: :environment do
    Case.all.each do |t|
      t.update_attribute :amount_obtained , 0
  end
  puts "done"
end

  # desc "TODO"
  #   task randerMonthly: :environment do
  #   # # view = ActionView::Base.new(ActionController::Base.view_paths, {}, ActionController::Base.new)
  #   # require 'open-uri'
  #   # # # works fine
  #   # # puts view.render(file: 'cases/monthly')
    
  #   # page = Nokogiri::HTML(open("http://127.0.0.1:3000/cases/monthly")) 
  #   # # doc.css(".item").each do |item|
  #   # #   puts item.content
  #   # # end
  #   Case.perform_monthly

  # end

end
