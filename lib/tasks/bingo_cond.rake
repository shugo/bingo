namespace :bingo do
  task :cond do
    puts [
      *(0..4).map { |i| (0..4).map { |j| "selected[#{i}][#{j}]" }.join("&&") },
      *(0..4).map { |i| (0..4).map { |j| "selected[#{j}][#{i}]" }.join("&&") },
      (0..4).map { |i| "selected[#{i}][#{i}]" }.join("&&"),
      (0..4).map { |i| "selected[#{i}][#{4-i}]" }.join("&&")
    ].join("||")
  end
end

