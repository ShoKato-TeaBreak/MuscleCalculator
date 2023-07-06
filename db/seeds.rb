# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Exercise.create!(
    [
      { name: "レッグプレス", mets_high: 8.0, mets_middle: 5.0, mets_low: 3.0 },
      { name: "レッグエクステンション", mets_high: 6.0, mets_middle: 4.0, mets_low: 3.0 },
      { name: "レッグカール", mets_high: 6.0, mets_middle: 4.0, mets_low: 3.0 },
      { name: "チェストプレス", mets_high: 7.0, mets_middle: 5.0, mets_low: 3.0 },
      { name: "ショルダープレス", mets_high: 7.0, mets_middle: 5.0, mets_low: 3.0 },
      { name: "ラットプルダウン", mets_high: 6.0, mets_middle: 4.0, mets_low: 3.0 },
      { name: "シーテッドロウ", mets_high: 6.0, mets_middle: 4.0, mets_low: 3.0 },
      { name: "アブドミナル", mets_high: 5.0, mets_middle: 3.0, mets_low: 2.0 },
      { name: "バックエクステンション", mets_high: 6.0, mets_middle: 4.0, mets_low: 2.0 },
      { name: "バイセップカール", mets_high: 6.0, mets_middle: 4.5, mets_low: 3.0 },
      { name: "ディップス", mets_high: 8.0, mets_middle: 6.0, mets_low: 4.0 },
      { name: "アダクション", mets_high: 5.0, mets_middle: 3.5, mets_low: 2.5 },
      { name: "アブダクション", mets_high: 5.0, mets_middle: 3.5, mets_low: 2.5 },
    ]
  )