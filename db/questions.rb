# What 3 towns have the highest population of citizens that are 65 years and older?
TownHealthRecord.order(population_greater_than_65_2005: :desc).limit(3).pluck(:town)
# TownHealthRecord.order(population_greater_than_65_2005: :desc).limit(3).offset(1).pluck(:town)

# What 3 towns have the highest population of citizens that are 19 years and younger?
TownHealthRecord.order(population_0_to_19_2005: :desc).limit(3).pluck(:town)

# What 5 towns have the lowest per capita income?
TownHealthRecord.order(:per_capita_income_2000).limit(5).pluck(:town)

# Omitting Boston, Becket, and Beverly, what town has the highest percentage of teen births?
TownHealthRecord.where("town != 'Boston' AND town != 'Becket' AND town != 'Beverly' AND percent_teen_births_2005_to_2008 IS NOT NULL").order(percent_teen_births_2005_to_2008: :desc).limit(1).pluck(:town, :percent_teen_births_2005_to_2008)

# Omitting Boston, what town has the highest number of infant mortalities?
TownHealthRecord.where("town != 'Boston' AND infant_mortality_rate_per_thousand_2005_to_2008 IS NOT NULL").order(infant_mortality_rate_per_thousand_2005_to_2008: :desc).limit(1).pluck(:town, :infant_mortality_rate_per_thousand_2005_to_2008)

# Of the 5 towns with the highest per capita income, which one has the highest number of people below the poverty line?
TownHealthRecord.where(town: TownHealthRecord.select(:town).order(per_capita_income_2000: :desc).limit(5)).order(persons_below_poverty_2000: :desc).limit(1).pluck(:town)

# Of the towns that start with the letter b, which has the highest population?
TownHealthRecord.where("town ILIKE 'b%'").order(total_population_2005: :desc).limit(1).pluck(:town, :total_population_2005)

# Of the 10 towns with the highest percent publicly financed prenatal care, are any of them also the top 10 for total infant deaths?
TownHealthRecord.where(town: TownHealthRecord.select(:town).where("percent_publicly_financed_prenatal_care_2005_to_2008 IS NOT NULL").order(percent_publicly_financed_prenatal_care_2005_to_2008: :desc).limit(10)).where(town: TownHealthRecord.select(:town).where("total_infant_deaths_2005_to_2008 IS NOT NULL").order(total_infant_deaths_2005_to_2008: :desc).limit(10)).pluck(:town)

#Which town has the highest percent multiple births?
TownHealthRecord.where("percent_multiple_births_2005_to_2008 IS NOT NULL").order(percent_multiple_births_2005_to_2008: :desc).limit(1).pluck(:town, :percent_multiple_births_2005_to_2008)

#What is the percent adequacy of prenatal care in that town?
TownHealthRecord.where(town: 'Dover').pluck(:town, :percent_adequacy_pre_natal_care)

#Excluding towns that start with W, how many towns are part of this data?
TownHealthRecord.where("NOT town ILIKE 'W%'").count(:town)

#How many towns have a lower per capita income that of Boston?
TownHealthRecord.where("per_capita_income_2000 < (SELECT per_capita_income_2000 FROM town_health_records WHERE town = 'Boston')").count(:town)
