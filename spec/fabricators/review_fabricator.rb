Fabricator(:review) do
  rating {  (1..5).to_a.sample }
  contents { Faker::Lorem.paragraph(3)  }
end