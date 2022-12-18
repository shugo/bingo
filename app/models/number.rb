class Number
  LOCK_FILE_PATH = File.expand_path("tmp/numbers.lock", Rails.root)
  TMP_JSON_FILE_PATH = File.expand_path("tmp/numbers.json", Rails.root)
  JSON_FILE_PATH = File.expand_path("public/numbers.json", Rails.root)

  def self.create
    synchronize do
      numbers = read_numbers
      return numbers if numbers.size >= 75
      candidates = (1..75).to_a - numbers
      numbers.push(candidates.sample)
      File.write(TMP_JSON_FILE_PATH, { numbers: numbers }.to_json)
      File.rename(TMP_JSON_FILE_PATH, JSON_FILE_PATH)
      numbers
    end
  end

  def self.clear
    synchronize do
      File.unlink(JSON_FILE_PATH)
    end
  rescue Errno::ENOENT
  end

  def self.all
    synchronize(shared: true) do
      read_numbers
    end
  end

  def self.read_numbers
    JSON.parse(File.read(JSON_FILE_PATH))["numbers"]
  rescue Errno::ENOENT, JSON::ParserError
    []
  end

  def self.synchronize(shared: false, &block)
    File.open(LOCK_FILE_PATH, "w") do |f|
      f.flock(shared ? File::LOCK_SH : File::LOCK_EX)
      block.call
    end
  end
end
