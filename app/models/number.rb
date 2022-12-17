class Number
  FILE_PATH = File.expand_path("db/numbers.csv", Rails.root)

  def self.create
    numbers = all
    return numbers if numbers.size >= 75
    candidates = (1..75).to_a - numbers
    numbers.push(candidates.sample)
    File.write(FILE_PATH, numbers.join(","))
    numbers
  end

  def self.clear
    File.unlink(FILE_PATH)
  rescue Errno::ENOENT
  end

  def self.all
    File.read(FILE_PATH).split(/,/).map(&:to_i)
  rescue Errno::ENOENT
    []
  end
end
