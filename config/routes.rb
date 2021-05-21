Rails.application.routes.draw do
  mount Decidim::Core::Engine => '/'
  
  authenticate :user, ->(u) { u.admin? } do
   mount Sidekiq::Web => "/sidekiq"
 end
end
