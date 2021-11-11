using Printf;
using Dates;

# gets the current timestamp in milliseconds
function time_ms()
    unix_timestamp = Dates.datetime2unix(Dates.unix2datetime(time()));
    
    return convert(Float64, unix_timestamp * 1000);
end

function random_numbers(n::Number) 
    # generate n random numbers ranging from 0 to n
    numbers = rand(0:(n + 1), n);
    
    # sort from lowest to highest
    sort!(numbers);
    
    delimeter = ",";
    pattern = r"\B(?=(\d{3})+(?!\d))";
    # convert each number to a string with thousands separators (e.g. 100,000)
    return map(x -> replace(string(x), pattern => delimeter), numbers);
end

start = time_ms();
random_numbers(1000000);
after = time_ms();
elapsed = after - start

@printf("%.03fms\n", elapsed);
