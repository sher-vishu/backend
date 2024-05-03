# Find and display duplicate records for "Model 1" and "Model 2"
duplicates = AiModel.where(name: ["Model 1", "Model 2"]).group(:name).having("count(*) > 1").pluck(:name)
puts "Duplicate models: #{duplicates}"

# Delete duplicate records for "Model 1" and "Model 2" except for the first occurrence
AiModel.where(name: duplicates).group(:name).having("count(*) > 1").each do |duplicate|
  AiModel.where(name: duplicate.name).offset(1).destroy_all
end