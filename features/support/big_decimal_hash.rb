# Process a hash and transform the values into BigDecimals,
# removing "$" signs
def bd_hash hash
  Hash[
    hash.map do |k, v|
      [k, BigDecimal.new(v.gsub("$",''))]
    end
  ]
end
