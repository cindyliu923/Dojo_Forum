class Rack::Attack

  # 一個 IP 位置每分鐘不得超過發送超過 180 個請求
  throttle('req/ip', :limit => 180, :period => 1.minutes) do |req|
    req.ip
  end

end
