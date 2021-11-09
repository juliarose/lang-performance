
def to_thousands(num)
    str = num.to_s
    len = str.length
    count = (len - 1) / 3
    i = 1
    
    while i <= count
        str = str.insert(len - (i * 3), ',')
        i += 1
    end
    
    str
end

start = Time.now

arr = Array.new(1000000)
    .map { rand(1...1000000) }
    .sort
    .map { |n| to_thousands(n) }

finish = Time.now
diff = finish - start

puts "#{(diff * 1000).round(3)}ms"
