IMAGE_URLS = %w(
  https://thumbs.dreamstime.com/t/purchasing-produce-fresh-stand-selling-fruits-vegetables-to-patron-putting-items-bag-35056277.jpg
  https://thumbs.dreamstime.com/t/hipster-girl-using-tablet-technology-home-atmosphere-girl-person-holding-computer-blank-screen-background-bokeh-female-134529000.jpg
  https://thumbs.dreamstime.com/t/my-beloved-kitty-right-day-i-found-her-middle-forest-behind-dead-mother-cat-was-days-old-eyes-were-135474517.jpg
  https://thumbs.dreamstime.com/t/glasses-fresh-organic-vegetable-fruit-juices-detox-diet-60978518.jpg
  https://thumbs.dreamstime.com/t/venice-lagoon-san-giorgio-church-gondolas-poles-italy-sunrise-maggiore-europe-130336254.jpg
  https://thumbs.dreamstime.com/t/hipster-guy-texting-his-mobile-phone-young-bar-having-cappuccino-55621892.jpg
  https://thumbs.dreamstime.com/t/back-view-woman-backpack-background-bokeh-light-night-atmospheric-city-blogger-hipster-planing-holiday-travel-mockup-124500188.jpg
  https://thumbs.dreamstime.com/t/laptop-computer-travel-37983668.jpg
  https://thumbs.dreamstime.com/t/laptop-tablet-smart-phone-table-wood-41008468.jpg
)

Country.create(
  name: 'United States',
  code: 'US'
)

Country.create(
  name: 'United Kingdom',
  code: 'UK'
)

45.times do
  country = Country.all.sample
  target_amount = (rand(1000..100000)/100).ceil * 100
  multiple = rand(2..10)
  c = Campaign.create(
    name: Faker::Company.name,
    image_url: IMAGE_URLS.sample,
    target_amount: target_amount,
    investment_multiple: multiple,
    sector: Faker::Company.industry,
    country: country,
  )

  rand(0..50).times do
    c.investments << Investment.create(
      amount: multiple * rand(1..10)
    )
  end
end
