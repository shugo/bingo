class Number
  LOCK_FILE_PATH = File.expand_path("tmp/numbers.lock", Rails.root)
  TMP_JSON_FILE_PATH = File.expand_path("tmp/numbers.json", Rails.root)
  JSON_FILE_PATH = File.expand_path("public/numbers.json", Rails.root)

  def self.create
    synchronize do
      numbers = read_numbers rescue []
      return numbers if numbers.size >= 75
      candidates = (1..75).to_a - numbers
      numbers.push(candidates.sample)
      write_numbers(numbers)
    end
  end

  def self.clear
    synchronize do
      write_numbers([])
    end
  end

  def self.all
    synchronize do
      begin
        read_numbers
      rescue Errno::ENOENT
        write_numbers([])
      end
    end
  end

  def self.read_numbers
    JSON.parse(File.read(JSON_FILE_PATH))["numbers"]
  end

  def self.write_numbers(numbers)
    File.write(TMP_JSON_FILE_PATH, { numbers: numbers }.to_json)
    File.rename(TMP_JSON_FILE_PATH, JSON_FILE_PATH)
    numbers
  end

  def self.synchronize(&block)
    File.open(LOCK_FILE_PATH, "w") do |f|
      f.flock(File::LOCK_EX)
      block.call
    end
  end
end
