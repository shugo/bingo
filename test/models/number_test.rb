require "test_helper"

class NumberTest < ActiveSupport::TestCase
  setup do
    File.unlink(Number::JSON_FILE_PATH)
  rescue Errno::ENOENT
  end

  test ".all" do
    assert_equal([], Number.all)
  end

  test ".create" do
    numbers = Number.create
    assert_equal(1, numbers.size)
    assert_equal(numbers, Number.all)
    numbers = Number.create
    assert_equal(2, numbers.size)
    assert_equal(numbers, Number.all)
  end

  test ".clear" do
    assert_equal([], Number.clear)
    assert_equal([], Number.all)
    Number.create
    assert_equal([], Number.clear)
    assert_equal([], Number.all)
  end
end
